%seasonalizes the simulated data by adding annual and daily cycles
%---------
%input arguments:

%simCapUtil: time series of simulated capacity utilisation without
    %seasonality
%average90Quantiles: contains the average monthly 0.9-quantiles of the
    %observed capacity utilisation transformed into hourly values 
%average10Quantiles: contains the average monthly 0.1-quantiles of the
    %observed capacity utilisation transformed into hourly values
%averageHourlyMeans: contains the average capacity utilisation observed in
    %every single hour of a day
    
%output arguments:

%seasonedSimCapUtil: (8760 x 1)-matrix; simulated capacity utilisation with
    %annual and daily seasonality (time series for one year)
%---------
%authors: Sebastian Ortlieb
%last update: 07/23/2010
%---------
function [seasonedSimCapUtil] = season(simCapUtil, average90Quantiles, average10Quantiles, averageHourlyMeans,simLength)

%add daily season
reshaped = reshape(simCapUtil, 24, []);

for i = 1 : length(reshaped(1,:))
    reshaped(:,i) = reshaped(:,i) + averageHourlyMeans - mean(simCapUtil);
end
daySeasonedSimCapUtil = reshape(reshaped,[],1);

%add annual season by simultaneously moving and stretching, so that monthly
%0,9- and 0,1-quantiles fit the original shape
hoursPerMonth = 730;
monthly90Quantiles = zeros(hoursPerMonth*12, 1);
monthly10Quantiles = zeros(hoursPerMonth*12, 1);

for j = 1 : 12
    monthly90Quantiles(1 + (j - 1)*hoursPerMonth : j*hoursPerMonth) =...
        quantile(daySeasonedSimCapUtil(1 + (j - 1)*hoursPerMonth : j*hoursPerMonth), 0.9);
    monthly10Quantiles(1 + (j - 1)*hoursPerMonth : j*hoursPerMonth) =...
        quantile(daySeasonedSimCapUtil(1 + (j - 1)*hoursPerMonth : j*hoursPerMonth), 0.1);
end

%compute average quantiles of the year
average90Quantile = mean(monthly90Quantiles);
average10Quantile = mean(monthly10Quantiles);

seasonedSimCapUtil = zeros(simLength,1);

for k = 1 : 8760
    stretchFactor = (average90Quantiles(k) - average10Quantiles(k)) / (average90Quantile - average10Quantile);
    movFactor = -average10Quantile * stretchFactor + average10Quantiles(k);
    seasonedSimCapUtil(k) = daySeasonedSimCapUtil(k) * stretchFactor + movFactor;
    %assure values between 0% and 100%
    if seasonedSimCapUtil(k) > 1
        seasonedSimCapUtil(k) = 1;%(seasonedSimCapUtil(k-1) + 1) / 2;
    elseif seasonedSimCapUtil(k) < 0
        seasonedSimCapUtil(k) = abs(seasonedSimCapUtil(k));
    end
end