%REVENUE CALCULATION 2020

function [Agg_SP_Rev35p5,Rev_SP35p5,Agg_Mer_Rev35p5,Rev_Mer35p5,Agg_CfD_Rev35p5,Rev_CfD35p5] = RevCalc_35p5(SimWind_CapFac_UP_Fin_35, SimPrices_35, p5, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP35p5 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_35(j,i)< p5
           Rev_SP35p5(j,i) = p5 * SimWind_CapFac_UP_Fin_35 (j,i); 
       elseif SimPrices_35(j,i)> p5
           Rev_SP35p5(j,i) = SimPrices_35(j,i) * SimWind_CapFac_UP_Fin_35 (j,i); 
       else SimPrices_35(j,i)= p5;
           Rev_SP35p5(j,i) = p5 * SimWind_CapFac_UP_Fin_35 (j,i);
       end
    end
end

Agg_SP_Rev35p5 = sum(Rev_SP35p5);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer35p5 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer35p5(j,i) = SimPrices_35 (j,i) * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end
    
Agg_Mer_Rev35p5 = sum(Rev_Mer35p5);

%CfD revenues (two-sided)
Rev_CfD35p5 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD35p5(j,i) = p5 * SimWind_CapFac_UP_Fin_35 (j,i);
    end
end

Agg_CfD_Rev35p5 = sum(Rev_CfD35p5);

end


