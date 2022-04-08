%REVENUE CALCULATION 2020

function [Agg_SP_Rev35p3,Rev_SP35p3,Agg_Mer_Rev35p3,Rev_Mer35p3,Agg_CfD_Rev35p3,Rev_CfD35p3] = RevCalc_35p3(SimWind_CapFac_UP_Fin_35, SimPrices_35, p3, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP35p3 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_35(j,i)< p3
           Rev_SP35p3(j,i) = p3 * SimWind_CapFac_UP_Fin_35 (j,i); 
       elseif SimPrices_35(j,i)> p3
           Rev_SP35p3(j,i) = SimPrices_35(j,i) * SimWind_CapFac_UP_Fin_35 (j,i); 
       else SimPrices_35(j,i)= p3;
           Rev_SP35p3(j,i) = p3 * SimWind_CapFac_UP_Fin_35 (j,i);
       end
    end
end

Agg_SP_Rev35p3 = sum(Rev_SP35p3);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer35p3 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer35p3(j,i) = SimPrices_35 (j,i) * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end
    
Agg_Mer_Rev35p3 = sum(Rev_Mer35p3);

%CfD revenues (two-sided)
Rev_CfD35p3 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD35p3(j,i) = p3 * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end

Agg_CfD_Rev35p3 = sum(Rev_CfD35p3);

end


