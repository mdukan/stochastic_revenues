

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%now create the final feed-in profile

function [feedInSeries,feedInContinous]=makeFeedInProfilePV(feedInDailyMax,monthlyMeanCycle)

%%%%%%%%%%%%%%%make output tables and arrays

%multiply the daily data with the maximum process
feedInSeries=bsxfun(@times,monthlyMeanCycle{:,2:25}, feedInDailyMax);

%dailyPatternTransformation{:,2:25}=feedInSeries;
%feedInSeriesTable = dailyPatternTransformation;
%makeDailyDateTable(1,1,2025,31,12,2025,cell({}));
%feedInSeriesTable{:,2:25}=feedInSeries;

feedInContinous=reshape(feedInSeries',1,size(feedInSeries,1)*size(feedInSeries,2));


end