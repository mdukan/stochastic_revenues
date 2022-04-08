%REVENUE CALCULATION 2020

function [Agg_SP_Rev25p8,Rev_SP25p8,Agg_Mer_Rev25p8,Rev_Mer25p8,Agg_CfD_Rev25p8,Rev_CfD25p8] = RevCalc_25p8(SimWind_CapFac_UP_Fin_25, SimPrices_25, p8, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP25p8 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_25(j,i)< p8
           Rev_SP25p8(j,i) = p8 * SimWind_CapFac_UP_Fin_25 (j,i); 
       elseif SimPrices_25(j,i)> p8
           Rev_SP25p8(j,i) = SimPrices_25(j,i) * SimWind_CapFac_UP_Fin_25 (j,i); 
       else SimPrices_25(j,i)= p8;
           Rev_SP25p8(j,i) = p8 * SimWind_CapFac_UP_Fin_25 (j,i);
       end
    end
end

Agg_SP_Rev25p8 = sum(Rev_SP25p8);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer25p8 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer25p8(j,i) = SimPrices_25 (j,i) * SimWind_CapFac_UP_Fin_25 (j,i);
    end
end
    
Agg_Mer_Rev25p8 = sum(Rev_Mer25p8);

%CfD revenues (two-sided)
Rev_CfD25p8 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD25p8(j,i) = p8 * SimWind_CapFac_UP_Fin_25 (j,i);
    end
end

Agg_CfD_Rev25p8 = sum(Rev_CfD25p8);

end


