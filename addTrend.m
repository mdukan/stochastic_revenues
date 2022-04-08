%Function to add trend component for the SimYear

function [Simstart,SimSeriesTrend] = addTrend(DataSeries,TrendCoeff,StartYear,SimYear,fundamental_price_level)
    
%Simstart is wrong!!!! when only used for simmulation of the last year!
    Simstart = 24*(datenum(SimYear,1,1)-datenum(StartYear,1,1));
    %Simstart=0;
    SimHours = 24*(datenum(SimYear,12,31)-datenum(SimYear-1,12,31));
    
    gradient = TrendCoeff(1);                 %Slope of the trend line
    intercept = TrendCoeff(2);             %y-axis intercept of the trend line
                                           %at the beginning of the StartYear
    SimSeriesTrend = zeros(length(DataSeries),1);
    for i=1:SimHours
        %SimSeriesTrend(i) = DataSeries(i) + intercept +  gradient*(Simstart + i);%gradient*( i); %
        MeanDataSeries = mean(DataSeries);
        SimSeriesTrend(i) = DataSeries(i) + (fundamental_price_level(SimYear-2019)- MeanDataSeries);
        % IMPORTANT: fundamental price level not working for 2020 - need to
        % simulate at least from 2021 - to get 2020 need to work with the
        % trend only
    end;