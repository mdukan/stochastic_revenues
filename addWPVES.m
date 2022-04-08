%computes the influence of wind energy feed-in on energy spot prices and
%adds the result to the simulated price time series
%---------
%input arguments:

%simSeries: simulated energy spot price time series without the influence
    %of wind energy feed-in and seasonalities
%simulatedWES: simulated time series of hourly wind energy feed-in during
    %one year
%LRCoeffsWES: contains the values of the average price reduction per MW
    %wind energy feed-in for each hour (columns) of different sample days
    %(rows)
%SimYear: the year the energy spot price is simulated for
    
%output arguments:

%WESaddedSeries: (8760 x 1)-matrix; simulated energy spot price time series
    %including the influence of wind energy feed-in
%---------
%authors: Sebastian Ortlieb, Joris Dehler
%last update: 01/12/2017
%---------
%---------added by Joris: based on "addWES1" function! include PV-feed-in!

function [WPVESaddedSeries,PVESaddedSeries,WESaddedSeries]...
    = addWPVES(simSeries, simulatedWES,simulatedPVES, LRCoeffsWES, LRCoeffsPVES, SimYear)

simDays = length(simSeries) / 24;
WESadd = zeros(simDays, 24);
%---------added by Joris
PVESadd = zeros(simDays, 24);

%separate every day of the input time series into a single row

shapedSimSeries = reshape(simSeries, 24, simDays)';
shapedSimWES = reshape(simulatedWES, 24, simDays)';
%---------added by Joris
shapedSimPVES = reshape(simulatedPVES, 24, simDays)';

%check every day of the simulated year, if it is a workday and, if yes, the
%season; then choose the corresponding average price reductions per MW wind
%energy feed-in for all hours of the day and multiply each with the hourly
%value of the simulated wind energy feed-in series to generate the
%influence of the wind energy feed-in 

DayDataSeries = datenum(SimYear, 1, 1);
for i = 1 : simDays
    
    if weekday(DayDataSeries) == 1 || weekday(DayDataSeries) == 7
        WESadd(i,:) = shapedSimWES(i,:) .* LRCoeffsWES(1,:);
        %---------added by Joris
        PVESadd(i,:) = shapedSimPVES(i,:) .* LRCoeffsPVES(1,:);
    else        
        if month(DayDataSeries) == 1 || month(DayDataSeries) == 2 || month(DayDataSeries) == 12
            WESadd(i,:) = shapedSimWES(i,:) .* LRCoeffsWES(2,:);
            %---------added by Joris
            PVESadd(i,:) = shapedSimPVES(i,:) .* LRCoeffsPVES(2,:);
        elseif month(DayDataSeries) == 3 || month(DayDataSeries) == 4 || month(DayDataSeries) == 5
            WESadd(i,:) = shapedSimWES(i,:) .* LRCoeffsWES(3,:);
            %---------added by Joris
            PVESadd(i,:) = shapedSimPVES(i,:) .* LRCoeffsPVES(3,:);
        elseif month(DayDataSeries) == 6 || month(DayDataSeries) == 7 || month(DayDataSeries) == 8
            WESadd(i,:) = shapedSimWES(i,:) .* LRCoeffsWES(4,:);
            %---------added by Joris
            PVESadd(i,:) = shapedSimPVES(i,:) .* LRCoeffsPVES(4,:);
        else
            WESadd(i,:) = shapedSimWES(i,:) .* LRCoeffsWES(5,:);
            %---------added by Joris
            PVESadd(i,:) = shapedSimPVES(i,:) .* LRCoeffsPVES(5,:);
        end
    end
    DayDataSeries = DayDataSeries + 1;
    
end

shapedWESaddedSeries = shapedSimSeries + WESadd;

shapedWPVESaddedSeries = shapedSimSeries + WESadd + PVESadd;
shapedPVESaddedSeries = shapedSimSeries + PVESadd;

WESaddedSeriesUnscaled = reshape(shapedWESaddedSeries', [], 1);

WPVESaddedSeriesUnscaled = reshape(shapedWPVESaddedSeries', [], 1);
PVESaddedSeriesUnscaled = reshape(shapedPVESaddedSeries', [], 1);

%scale WESaddedSeries (mean =! 0)

WESaddedSeries = WESaddedSeriesUnscaled;

WPVESaddedSeries = WPVESaddedSeriesUnscaled;
PVESaddedSeries = PVESaddedSeriesUnscaled;