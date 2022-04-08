%REVENUE CALCULATION 2020

function [Agg_SP_Rev30p4,Rev_SP30p4,Agg_Mer_Rev30p4,Rev_Mer30p4,Agg_CfD_Rev30p4,Rev_CfD30p4] = RevCalc_30p4(SimWind_CapFac_UP_Fin_30, SimPrices_30, p4, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP30p4 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_30(j,i)< p4
           Rev_SP30p4(j,i) = p4 * SimWind_CapFac_UP_Fin_30 (j,i); 
       elseif SimPrices_30(j,i)> p4
           Rev_SP30p4(j,i) = SimPrices_30(j,i) * SimWind_CapFac_UP_Fin_30 (j,i); 
       else SimPrices_30(j,i)= p4;
           Rev_SP30p4(j,i) = p4 * SimWind_CapFac_UP_Fin_30 (j,i);
       end
    end
end

Agg_SP_Rev30p4 = sum(Rev_SP30p4);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer30p4 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer30p4(j,i) = SimPrices_30 (j,i) * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end
    
Agg_Mer_Rev30p4 = sum(Rev_Mer30p4);

%CfD revenues (two-sided)
Rev_CfD30p4 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD30p4(j,i) = p4 * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end

Agg_CfD_Rev30p4 = sum(Rev_CfD30p4);

end


