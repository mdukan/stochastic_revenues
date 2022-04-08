%REVENUE CALCULATION 2020

function [Agg_SP_Rev30p7,Rev_SP30p7,Agg_Mer_Rev30p7,Rev_Mer30p7,Agg_CfD_Rev30p7,Rev_CfD30p7] = RevCalc_30p7(SimWind_CapFac_UP_Fin_30, SimPrices_30, p7, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP30p7 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_30(j,i)< p7
           Rev_SP30p7(j,i) = p7 * SimWind_CapFac_UP_Fin_30 (j,i); 
       elseif SimPrices_30(j,i)> p7
           Rev_SP30p7(j,i) = SimPrices_30(j,i) * SimWind_CapFac_UP_Fin_30 (j,i); 
       else SimPrices_30(j,i)= p7;
           Rev_SP30p7(j,i) = p7 * SimWind_CapFac_UP_Fin_30 (j,i);
       end
    end
end

Agg_SP_Rev30p7 = sum(Rev_SP30p7);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer30p7 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer30p7(j,i) = SimPrices_30 (j,i) * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end
    
Agg_Mer_Rev30p7 = sum(Rev_Mer30p7);

%CfD revenues (two-sided)
Rev_CfD30p7 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD30p7(j,i) = p7 * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end

Agg_CfD_Rev30p7 = sum(Rev_CfD30p7);

end


