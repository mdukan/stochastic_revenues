%REVENUE CALCULATION 2020

function [Agg_SP_Rev50p1,Rev_SP50p1,Agg_Mer_Rev50p1,Rev_Mer50p1,Agg_CfD_Rev50p1,Rev_CfD50p1] = RevCalc_50p1(SimWind_CapFac_UP_Fin_50, SimPrices_50, p1, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP50p1 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_50(j,i)< p1
           Rev_SP50p1(j,i) = p1 * SimWind_CapFac_UP_Fin_50 (j,i); 
       elseif SimPrices_50(j,i)> p1
           Rev_SP50p1(j,i) = SimPrices_50(j,i) * SimWind_CapFac_UP_Fin_50 (j,i); 
       else SimPrices_50(j,i)= p1;
           Rev_SP50p1(j,i) = p1 * SimWind_CapFac_UP_Fin_50 (j,i);
       end
    end
end

Agg_SP_Rev50p1 = sum(Rev_SP50p1);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer50p1 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer50p1(j,i) = SimPrices_50 (j,i) * SimWind_CapFac_UP_Fin_50 (j,i);
    end
end
    
Agg_Mer_Rev50p1 = sum(Rev_Mer50p1);

%CfD revenues (two-sided)
Rev_CfD50p1 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD50p1(j,i) = p1 * SimWind_CapFac_UP_Fin_50 (j,i);
    end
end

Agg_CfD_Rev50p1 = sum(Rev_CfD50p1);

end


