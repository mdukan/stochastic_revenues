%REVENUE CALCULATION 2020

function [Agg_SP_Rev35p2,Rev_SP35p2,Agg_Mer_Rev35p2,Rev_Mer35p2,Agg_CfD_Rev35p2,Rev_CfD35p2] = RevCalc_35p2(SimWind_CapFac_UP_Fin_35, SimPrices_35, p2, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP35p2 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_35(j,i)< p2
           Rev_SP35p2(j,i) = p2 * SimWind_CapFac_UP_Fin_35 (j,i); 
       elseif SimPrices_35(j,i)> p2
           Rev_SP35p2(j,i) = SimPrices_35(j,i) * SimWind_CapFac_UP_Fin_35 (j,i); 
       else SimPrices_35(j,i)= p2;
           Rev_SP35p2(j,i) = p2 * SimWind_CapFac_UP_Fin_35 (j,i);
       end
    end
end

Agg_SP_Rev35p2 = sum(Rev_SP35p2);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer35p2 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer35p2(j,i) = SimPrices_35 (j,i) * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end
    
Agg_Mer_Rev35p2 = sum(Rev_Mer35p2);

%CfD revenues (two-sided)
Rev_CfD35p2 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD35p2(j,i) = p2 * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end

Agg_CfD_Rev35p2 = sum(Rev_CfD35p2);

end


