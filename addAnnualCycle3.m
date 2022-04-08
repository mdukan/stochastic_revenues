function [AnnualCycleSeries] = addAnnualCycle3(WeeklyCycleSeries, avgMonthlyMeans)

hoursPerMonth = length(WeeklyCycleSeries)/12;
shapedWeeklyCycleSeries = reshape(WeeklyCycleSeries, hoursPerMonth, []);
shapedAnnualCycleSeries = zeros(hoursPerMonth, 12);

for m = 1:12
    shapedAnnualCycleSeries(:,m) = shapedWeeklyCycleSeries(:,m) + avgMonthlyMeans(m);
end

AnnualCycleSeries = reshape(shapedAnnualCycleSeries, [], 1);