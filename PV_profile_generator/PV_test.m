    %%%%%%%%%%%%% PV pre-simulation data provision:
    [deseasonalisedY,dailyCycle,yearlyCycle,seasonsFit,Y]=...
    deseasonaliseYearlyDailyPV(hourlyPVES, StartYear, EndYear, installCapacity );
    %capacity at the end of the previous year is used for a specific year
    %to account for the fact that most capacity is built at the end of a
    %year is avalaible then for the next year
    EstMdlSolar=estimateSolarArima(deseasonalisedY);
    
    dailyMeanCycle=monthlyMeanProfile(dailyCycle,SimHours/24);
    
    [simulatedPVES]=simulatePVES(yearlyCycle,dailyCycle,installCapacity(2,SimYear-2005),SimHours/24,EstMdlSolar,dailyMeanCycle);