%REVENUE CALCULATION 2020

function [Agg_SP_Rev30p6,Rev_SP30p6,Agg_Mer_Rev30p6,Rev_Mer30p6,Agg_CfD_Rev30p6,Rev_CfD30p6] = RevCalc_30p6(SimWind_CapFac_UP_Fin_30, SimPrices_30, p6, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP30p6 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_30(j,i)< p6
           Rev_SP30p6(j,i) = p6 * SimWind_CapFac_UP_Fin_30 (j,i); 
       elseif SimPrices_30(j,i)> p6
           Rev_SP30p6(j,i) = SimPrices_30(j,i) * SimWind_CapFac_UP_Fin_30 (j,i); 
       else SimPrices_30(j,i)= p6;
           Rev_SP30p6(j,i) = p6 * SimWind_CapFac_UP_Fin_30 (j,i);
       end
    end
end

Agg_SP_Rev30p6 = sum(Rev_SP30p6);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer30p6 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer30p6(j,i) = SimPrices_30 (j,i) * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end
    
Agg_Mer_Rev30p6 = sum(Rev_Mer30p6);

%CfD revenues (two-sided)
Rev_CfD30p6 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD30p6(j,i) = p6 * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end

Agg_CfD_Rev30p6 = sum(Rev_CfD30p6);

end


