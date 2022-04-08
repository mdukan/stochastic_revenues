%Function to defund negative prices into the simulated Price series.
function [RetransformedSeries] = RetransformNegPrices(DataSeries,delta,ProbNegPrice,NegPrices)  
    SimHours = length(DataSeries);
    RetransformedSeries = DataSeries;
    
    %Determine the number of negative jumps within the simulted price
    %series
    numberNegJumps = 0;
    for j=1:SimHours
        if DataSeries(j)>3000  %Prices above 3000€ are catched by this constraint
            DataSeries(j)=3000;
        end
        if delta(j) == -1
            numberNegJumps = numberNegJumps+1;
        end
    end
    
    NormCoeffNP = mle(NegPrices);
    %Transforming "some" of the negative jumps into negative prices using
    %bimodal distribution
    for k=1:SimHours
        if delta(k) == -1
            HV = rand();
            ProbNegPriceJumps = ProbNegPrice/(numberNegJumps/SimHours);
            if HV <= ProbNegPriceJumps
                %RetransformedSeries(k,1)= normrnd(NormCoeffNP(1),NormCoeffNP(2));
                RetransformedSeries(k,1)= bimodrnd(NegPrices);
            end;
        end;
    end;
end