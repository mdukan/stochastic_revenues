%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%make the step function as in Wagner
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%(2012)


function monthlymean=makeMeanStepFunction(solarDateTable)

for month=1:12
    
monthROWS=solarDateTable.date.Month==month;

monthlymean(month,1:24) = mean( bsxfun(@rdivide,solarDateTable{monthROWS,1:24},max(solarDateTable{monthROWS,1:24},[],2) ) );
    
end

end