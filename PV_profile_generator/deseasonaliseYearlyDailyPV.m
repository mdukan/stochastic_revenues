%this function deseasonalises the given time series and returns different
%seasonal properties

%% input
%time series must start at the first of january to the 31st of december of
%the @startyear to the @endyear
%capacities in the years can be handed over as vector

%% output:
%deseasonalised time series for each year
%
%the hourly means calculated over the months for producing the daily
%pattern of feed-in
%
%The average of the seasonal fit over all years
%
%all seasonal fits as a matrix
%%
function [deseasonalisedY,dailyCycle,yearlyCycle,seasonsFit,Y]=deseasonaliseYearlyDailyPV(PVfeedInHourly, startyear,endyear, capacity)

solarFeedIn24hours=reshape(PVfeedInHourly,24,size(PVfeedInHourly,1)/24)';

days= size(solarFeedIn24hours,1);

%eliminate the data at nighttime. 
solarFeedIn24hours= [zeros(days,4) solarFeedIn24hours(:,5:20) zeros(days,4)];

%add a date to the feed-in profile for easy handing
solarDateTable=makeDailyDateTable(1,1,startyear,31,12,endyear,solarFeedIn24hours);

%this is the daily cycle
dailyCycle=makeMeanStepFunction(solarDateTable);


%loop through all the years and deseasonalize every year. store all the
%seasonal functions in @seasonsFit
for year=startyear:endyear

yearROWS=solarDateTable.date.Year==year;    

[deseasonalisedY(:,year-startyear+1),Y(:,year-startyear+1),betaSeasonFit(year-startyear+1,:)]=...
    deseasonaliseYearly(solarFeedIn24hours(yearROWS,:),mean([capacity(1,year - 2011+1) capacity(1,year - 2011+2)]) );


seasonsFit(:,year-startyear+1)=trigoFit(betaSeasonFit(year-startyear+1,:),1:366);
end



%averaging the yearly seasonal components yields the yearly cycle
yearlyCycle=mean(seasonsFit,2);

deseasonalisedY= reshape(deseasonalisedY',[],1);

end 