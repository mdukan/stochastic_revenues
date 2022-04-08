%REVENUE CALCULATION 2020

function [Agg_SP_Rev30p10,Rev_SP30p10,Agg_Mer_Rev30p10,Rev_Mer30p10,Agg_CfD_Rev30p10,Rev_CfD30p10] = RevCalc_30p10(SimWind_CapFac_UP_Fin_30, SimPrices_30, p10, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP30p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_30(j,i)< p10
           Rev_SP30p10(j,i) = p10 * SimWind_CapFac_UP_Fin_30 (j,i); 
       elseif SimPrices_30(j,i)> p10
           Rev_SP30p10(j,i) = SimPrices_30(j,i) * SimWind_CapFac_UP_Fin_30 (j,i); 
       else SimPrices_30(j,i)= p10;
           Rev_SP30p10(j,i) = p10 * SimWind_CapFac_UP_Fin_30 (j,i);
       end
    end
end

Agg_SP_Rev30p10 = sum(Rev_SP30p10);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer30p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer30p10(j,i) = SimPrices_30 (j,i) * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end
    
Agg_Mer_Rev30p10 = sum(Rev_Mer30p10);

%CfD revenues (two-sided)
Rev_CfD30p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD30p10(j,i) = p10 * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end

Agg_CfD_Rev30p10 = sum(Rev_CfD30p10);

end


