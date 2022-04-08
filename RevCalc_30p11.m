%REVENUE CALCULATION 2020

function [Agg_SP_Rev30p11,Rev_SP30p11,Agg_Mer_Rev30p11,Rev_Mer30p11,Agg_CfD_Rev30p11,Rev_CfD30p11] = RevCalc_30p11(SimWind_CapFac_UP_Fin_30, SimPrices_30, p11, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP30p11 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_30(j,i)< p11
           Rev_SP30p11(j,i) = p11 * SimWind_CapFac_UP_Fin_30 (j,i); 
       elseif SimPrices_30(j,i)> p11
           Rev_SP30p11(j,i) = SimPrices_30(j,i) * SimWind_CapFac_UP_Fin_30 (j,i); 
       else SimPrices_30(j,i)= p11;
           Rev_SP30p11(j,i) = p11 * SimWind_CapFac_UP_Fin_30 (j,i);
       end
    end
end

Agg_SP_Rev30p11 = sum(Rev_SP30p11);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer30p11 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer30p11(j,i) = SimPrices_30 (j,i) * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end
    
Agg_Mer_Rev30p11 = sum(Rev_Mer30p11);

%CfD revenues (two-sided)
Rev_CfD30p11 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD30p11(j,i) = p11 * SimWind_CapFac_UP_Fin_30 (j,i);
    end
end

Agg_CfD_Rev30p11 = sum(Rev_CfD30p11);

end


