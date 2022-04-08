%pv as autoregressive series

function feedInDailyMax=makeDailyMaxSeries(averageSeason,simulationDays,EstMdl)

%cut off one day of the average season if its not a leapyear
if simulationDays==365
averageSeason=averageSeason(1:end-1,:);
end

%simulate some time series based on the model we developed. Possible to use
%this for monte-carlo runs!
[simulatedY,E] = simulate(EstMdl,simulationDays);

%histfit(simulatedY);
%the sigmoidal function sigmf with a = 1 and c = 0 is the inverse of the
%logit function
feedInDailyMax = sigmf(simulatedY + averageSeason,[1 0]);

%trigoFit(beta,1:size(deseasonalisedY,1))


end
%autocorr(feedInSeries);











