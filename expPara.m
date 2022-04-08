%depending on capacity utilisation levels, this function analyses the
%distributions of the first order differences of the wind energy feed-in
%capacity utilisation; then it returns coefficients with which parameters
%can be computed, that describe the differences' distributions depending on
%capacity utilisation levels
%---------
%input arguments:

%CapacityUtilisation: observed capacity utilisation of the total installed
    %wind energy feed-in capacity (hourly values)
%MovavgLag: lag-parameter of a moving average; defines the capacity
    %utilisation level, because the level consists of the moving average of
    %the last MovavgLag capacity utilisation values

%output arguments:

%pfParaPosMean: (1 x 3)-matrix; contains coefficients for the parameter
    %PosMean (µ+) gained from linear regression (order 2)
%pfParaNegMean: (1 x 2)-matrix; contains coefficients for the parameter
    %NegMean (µ-) gained from linear regression (order 1)
%pfParaMode: (1 x 2)-matrix; contains coefficients for the parameter
    %Mode (m) gained from linear regression (order 1)
%---------
%authors: Sebastian Ortlieb
%last update: 07/23/2010
%---------
function [pfParaPosMean, pfParaNegMean, pfParaMode] = expPara(CapacityUtilisation, MovavgLag)

%define right edges of intervals for grouping capacity utilisation levels
intervals = [0.02:0.01:0.14, 0.18, 0.20, 0.23, 0.25, 0.28, 0.3, 0.34, 0.38, 0.41, 0.44, 0.56, 0.70, inf];

%compute centre of each interval
centres = zeros(1, length(intervals));
centres(1) = 0.01;
centres(end) = 0.85;
for l = 2 : length(intervals) - 1
    centres(l) = (intervals(l) + intervals(l - 1)) / 2;
end

%compute simple moving average for capacity utilisation
CapUtilMovavg = tsmovavg(CapacityUtilisation, 's', MovavgLag, 1);
%compute first degree differences of capacity utilisation
CapUtilDiff = diff(CapacityUtilisation);
%cut data series due to missing values in moving average series
CutCapUtilMovavg = CapUtilMovavg(MovavgLag : length(CapUtilDiff));
CutCapUtilDiff = CapUtilDiff(MovavgLag : length(CapUtilDiff));
%sort data series
[sortedCapUtilMovavg, indexSort] = sort(CutCapUtilMovavg);
sortedCapUtilDiff = CutCapUtilDiff(indexSort);

%preallocate output
PosParaList = zeros(2, length(intervals));
NegParaList = zeros(2, length(intervals));
IndexList = zeros(2, length(intervals));

%group capacity utilisation moving average into 1%-intervals and compute
%output parameters for each interval (negative values are put into the
%first interval)
startInterval = 1;
outputColumn = 0;
for i = intervals
    outputColumn = outputColumn + 1;
    endInterval = startInterval;
    while sortedCapUtilMovavg(endInterval) < i
        endInterval = endInterval + 1;
        if endInterval > length(sortedCapUtilMovavg)
            break;
        end
    end
    %check if interval contains values
    if endInterval ~= startInterval
        %group corresponding capacity utilisation differences into
        %intervals
        CapUtilDiffInterval = sortedCapUtilDiff(startInterval : endInterval - 1);
        
        if numel(CapUtilDiffInterval) < 2
            ModeValue = CapUtilDiffInterval;
            posMean = 0;
            negMean = 0;
        else
            %identify most frequented bin and mode value using histogram
            %create bins for histogram
            edges = [min(CapUtilDiffInterval) : 0.001 : max(CapUtilDiffInterval), inf];
            counts = histc(CapUtilDiffInterval, edges);
            [sortedCounts, indexCounts] = sort(counts, 'descend');
            k = 1;
            while sortedCounts(k + 1) == sortedCounts(k)
                k = k + 1;
            end
            
            ModeValue = min(CapUtilDiffInterval) +...
                0.001*((indexCounts(1) + indexCounts(k)) / 2 - 0.5);
    
            %separate CapUtilDiffInterval into differences bigger and
            %smaller than ModeValue
            sortedCapUtilDiffInterval = sort(CapUtilDiffInterval);
            j = 1;
            while sortedCapUtilDiffInterval(j) < ModeValue
                j = j + 1;
            end
            posCapUtilDiffInterval = sortedCapUtilDiffInterval(j :...
                                length(sortedCapUtilDiffInterval));
            negCapUtilDiffInterval = sortedCapUtilDiffInterval(1 : j - 1);
    
            %identify mean value
            posMean = mean(posCapUtilDiffInterval - ModeValue);
            negMean = abs(mean(negCapUtilDiffInterval - ModeValue));
        end
        
        %fill output matrices
        PosParaList(:,outputColumn) = [posMean; ModeValue];
        NegParaList(:,outputColumn) = [negMean; ModeValue];
        IndexList(:,outputColumn) = [startInterval; endInterval - 1];
    end        
    
    startInterval = endInterval;
    if endInterval > length(sortedCapUtilMovavg)
        break;
    end
end

%create continuous function for parameters mean and mode with polyfit (pf)
pfParaPosMean = polyfit(centres, PosParaList(1,:), 2);
pfParaNegMean = polyfit(centres, NegParaList(1,:), 1);
pfParaMode = polyfit(centres, PosParaList(2,:), 1);