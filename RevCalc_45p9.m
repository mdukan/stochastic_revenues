%REVENUE CALCULATION 2020

function [Agg_SP_Rev45p9,Rev_SP45p9,Agg_Mer_Rev45p9,Rev_Mer45p9,Agg_CfD_Rev45p9,Rev_CfD45p9] = RevCalc_45p9(SimWind_CapFac_UP_Fin_45, SimPrices_45, p9, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP45p9 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_45(j,i)< p9
           Rev_SP45p9(j,i) = p9 * SimWind_CapFac_UP_Fin_45 (j,i); 
       elseif SimPrices_45(j,i)> p9
           Rev_SP45p9(j,i) = SimPrices_45(j,i) * SimWind_CapFac_UP_Fin_45 (j,i); 
       else SimPrices_45(j,i)= p9;
           Rev_SP45p9(j,i) = p9 * SimWind_CapFac_UP_Fin_45 (j,i);
       end
    end
end

Agg_SP_Rev45p9 = sum(Rev_SP45p9);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer45p9 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer45p9(j,i) = SimPrices_45 (j,i) * SimWind_CapFac_UP_Fin_45 (j,i);
    end
end
    
Agg_Mer_Rev45p9 = sum(Rev_Mer45p9);

%CfD revenues (two-sided)
Rev_CfD45p9 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD45p9(j,i) = p9 * SimWind_CapFac_UP_Fin_45 (j,i);
    end
end

Agg_CfD_Rev45p9 = sum(Rev_CfD45p9);

end

