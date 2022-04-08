%REVENUE CALCULATION 2020

function [Agg_SP_Rev45p10,Rev_SP45p10,Agg_Mer_Rev45p10,Rev_Mer45p10,Agg_CfD_Rev45p10,Rev_CfD45p10] = RevCalc_45p10(SimWind_CapFac_UP_Fin_45, SimPrices_45, p10, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP45p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices_45(j,i)< p10
           Rev_SP45p10(j,i) = p10 * SimWind_CapFac_UP_Fin_45 (j,i); 
       elseif SimPrices_45(j,i)> p10
           Rev_SP45p10(j,i) = SimPrices_45(j,i) * SimWind_CapFac_UP_Fin_45 (j,i); 
       else SimPrices_45(j,i)= p10;
           Rev_SP45p10(j,i) = p10 * SimWind_CapFac_UP_Fin_45 (j,i);
       end
    end
end

Agg_SP_Rev45p10 = sum(Rev_SP45p10);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer45p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer45p10(j,i) = SimPrices_45 (j,i) * SimWind_CapFac_UP_Fin_45 (j,i);
    end
end
    
Agg_Mer_Rev45p10 = sum(Rev_Mer45p10);

%CfD revenues (two-sided)
Rev_CfD45p10 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD45p10(j,i) = p10 * SimWind_CapFac_UP_Fin_45 (j,i);
    end
end

Agg_CfD_Rev45p10 = sum(Rev_CfD45p10);

end


