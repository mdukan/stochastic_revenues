%REVENUE CALCULATION 2020

function [Agg_SP_Rev35p7,Rev_SP35p7,Agg_Mer_Rev35p7,Rev_Mer35p7,Agg_CfD_Rev35p7,Rev_CfD35p7] = RevCalc_35p7(SimWind_CapFac_UP_Fin_35, SimPrices_35, p7, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP35p7 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_35(j,i)< p7
           Rev_SP35p7(j,i) = p7 * SimWind_CapFac_UP_Fin_35 (j,i); 
       elseif SimPrices_35(j,i)> p7
           Rev_SP35p7(j,i) = SimPrices_35(j,i) * SimWind_CapFac_UP_Fin_35 (j,i); 
       else SimPrices_35(j,i)= p7;
           Rev_SP35p7(j,i) = p7 * SimWind_CapFac_UP_Fin_35 (j,i);
       end
    end
end

Agg_SP_Rev35p7 = sum(Rev_SP35p7);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer35p7 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer35p7(j,i) = SimPrices_35 (j,i) * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end
    
Agg_Mer_Rev35p7 = sum(Rev_Mer35p7);

%CfD revenues (two-sided)
Rev_CfD35p7 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD35p7(j,i) = p7 * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end

Agg_CfD_Rev35p7 = sum(Rev_CfD35p7);

end


