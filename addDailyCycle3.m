%adds the daily cycle to the simulated time series
%-------
%input arguments:

%WESaddedSeries: simulated energy spot price time series including the
    %influence of wind energy feed-in
%dailySeason: daily season of the original series for each day along the
    %year (weekends are treated as workdays)
%WeekendHourlyMeans: average means for every hour of the weekends of the
    %original time series
%SimYear: the year the energy spot price is simulated for

%output arguments:

%DailyCycleSeries: (8760 x 1)-matrix; simulated energy spot price time
    %series including both the influence of wind energy feed-in and the
    %daily seasonality
%---------
%authors: Sebastian Ortlieb
%last update: 07/23/2010
%---------
function [DailyCycleSeries] = addDailyCycle3(WESaddedSeries, dailySeason, WeekendHourlyMeans, SimYear)

%separate every day of the input time series into a single column
simLength = 24*(datenum(SimYear,12,31)-datenum(SimYear-1,12,31));

shapedWESaddedSeries = reshape(WESaddedSeries, 24, simLength/24);

%add daily cycle for workdays (ignore weekends)

shapedDailyCycleSeries = shapedWESaddedSeries + dailySeason;

%add daily cycle for weekends

DayDataSeries = datenum(SimYear, 1, 1);

for day = 1 : (simLength/24)
    if weekday(DayDataSeries) == 1 || weekday(DayDataSeries) == 7
        shapedDailyCycleSeries(:, day) = shapedWESaddedSeries(:, day) + WeekendHourlyMeans';
    end
    DayDataSeries = DayDataSeries + 1;
end

DailyCycleSeries = reshape(shapedDailyCycleSeries, [], 1);