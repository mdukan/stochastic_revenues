function dailyPatternTransformation=monthlyMeanProfile(stepFunction,lengthSeries)


if lengthSeries==365
    dailyPatternTransformation = makeDailyDateTable(1,1,2025,31,12,2025,cell({}));
else
    dailyPatternTransformation = makeDailyDateTable(1,1,2020,31,12,2020,cell({}));
end 

%make a table with date and the average profiles on every day of the month.
%this is based on the chosen step function
for month=1:12
   
    monthROWS=dailyPatternTransformation.date.Month==month;
    
    monthMeanProfile=bsxfun(@times,ones(sum(monthROWS),24),stepFunction(month,1:24));
    
    dailyPatternTransformation{monthROWS,2:25}=monthMeanProfile; 
    
end


end