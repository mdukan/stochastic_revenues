%REVENUE CALCULATION 2020

function [Agg_SP_Rev35p10,Rev_SP35p10,Agg_Mer_Rev35p10,Rev_Mer35p10,Agg_CfD_Rev35p10,Rev_CfD35p10] = RevCalc_35p10(SimWind_CapFac_UP_Fin_35, SimPrices_35, p10, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP35p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_35(j,i)< p10
           Rev_SP35p10(j,i) = p10 * SimWind_CapFac_UP_Fin_35 (j,i); 
       elseif SimPrices_35(j,i)> p10
           Rev_SP35p10(j,i) = SimPrices_35(j,i) * SimWind_CapFac_UP_Fin_35 (j,i); 
       else SimPrices_35(j,i)= p10;
           Rev_SP35p10(j,i) = p10 * SimWind_CapFac_UP_Fin_35 (j,i);
       end
    end
end

Agg_SP_Rev35p10 = sum(Rev_SP35p10);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer35p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer35p10(j,i) = SimPrices_35 (j,i) * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end
    
Agg_Mer_Rev35p10 = sum(Rev_Mer35p10);

%CfD revenues (two-sided)
Rev_CfD35p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD35p10(j,i) = p10 * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end

Agg_CfD_Rev35p10 = sum(Rev_CfD35p10);

end


