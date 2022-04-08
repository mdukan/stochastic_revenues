

function [feedInContinous]=simulatePVES(averageSeasonFit,capacity,simulationDays,EstMdl,monthlyMeanCycle)

dailyMaxFeedIn=makeDailyMaxSeries(averageSeasonFit,simulationDays,EstMdl);

[feedInSeries,feedInContinous]=makeFeedInProfilePV(dailyMaxFeedIn,monthlyMeanCycle);

feedInContinous=feedInContinous.*capacity;

end