%simulates hourly values of the capacity utilisation of wind energy feed-in
%for one year
%---------
%input arguments:

%CapacityUtilisation: observed capacity utilisation of the total installed
    %wind energy feed-in capacity (hourly values)
%installCapacity: totally installed wind energy feed-in capacity

%output arguments:

%simulatedWES: (8760 x 1)-matrix; simulated time series of hourly wind
    %energy feed-in during one year
%---------
%this function uses the following other functions (in alphabetical order;
%except standard Matlab-functions):

%deseason
%expPara
%laplacernd
%mova
%rndIntervalLengths
%season
%---------
%authors: Dogan Keles & Sebastian Ortlieb
%last update: 25/03/2011
%---------
function [simulatedWES] = ...
          simulateWES(CapacityUtilisation, installCapacity,SimYear)

%deseasonalize capacity utilisation
[deseasonedCapUtil, average90Quantiles, average10Quantiles,...
    averageHourlyMeans,movFactor,stretchFactor] =...
    deseason(CapacityUtilisation);

%define simulation Length
simLength = 24*(datenum(SimYear,12,31)-datenum(SimYear-1,12,31));
%create first order differences of capacity utilisation
CapUtilDiff = diff(deseasonedCapUtil);
%identify lag for moving average
MovavgLag = mova(deseasonedCapUtil, 168);

%compute parameters for the distributions of the simulated first order
%differences of the WES capacity utilisation
[pfParaPosMean, pfParaNegMean, pfParaMode] = expPara(deseasonedCapUtil, MovavgLag);

%create list of interval lengths for intervals with all-positive or
%all-negative capacity differences
intLengths = rndIntervalLengths(CapUtilDiff, simLength - MovavgLag);

%compute first MovavgLag differences for further simulation
%identify parameters for Laplace-distribution
mu = median(CapUtilDiff);
sigma = sum(abs(CapUtilDiff - mu))/length(CapUtilDiff);
%create Laplace(mu,sigma)-distributed numbers (possible diffWES)
simCapUtilDiff = laplacernd(mu, sigma, MovavgLag - 1, 1);

%simulate capacity utilisation

%first MovavgLag values
simCapUtil = mean(deseasonedCapUtil);
for i = 1:length(simCapUtilDiff)
    simCapUtil(i + 1, 1) = simCapUtil(i, 1) + simCapUtilDiff(i, 1);
end

%translate intLengths into a vector containing 1s and -1s; a 1 later means 
%a positive capacity utilisation difference, a -1 a negativ one
firstSign = sign(simCapUtilDiff(length(simCapUtilDiff)));
SignList = ones(sum(intLengths),1);
if firstSign > 0
    for k = 1:2:length(intLengths)
        SignList(sum(intLengths(1:k)) - intLengths(k) + 1 : sum(intLengths(1:k))) = -1;
    end
else
    for k = 2:2:length(intLengths)
        SignList(sum(intLengths(1:k-1)) + 1 : sum(intLengths(1:k))) = -1;
    end
end

%simulate further values
for i = MovavgLag + 1 : simLength
    %compute moving average for correct parameters mean and mode (assure
    %positive mean)
    MovAvg = mean(simCapUtil(i - MovavgLag : i - 1));
    %check SignList for correct parameter list and compute mean value
    if SignList(i - MovavgLag) == -1
        Mean = abs(pfParaNegMean(1) * MovAvg + pfParaNegMean(2));
    else
        Mean = abs(pfParaPosMean(1) * MovAvg^2 + pfParaPosMean(2) * MovAvg + pfParaPosMean(3));
    end    
    %compute mode value
    Mode = pfParaMode(1) * MovAvg + pfParaMode(2);
    
    %compute capacity utilisation difference
    Diff = SignList(i - MovavgLag) * exprnd(Mean) + Mode;
    %compute capacity utilisation
    simCapUtil(i) = simCapUtil(i-1) + Diff;
end

%seasonalize data

seasonedSimCapUtil = season(simCapUtil, average90Quantiles, average10Quantiles, averageHourlyMeans,simLength);

%multiply simulated capacity utilisation with totally installed capacity to
%get simulated wind energy feed-in

simulatedWES = seasonedSimCapUtil .* installCapacity;