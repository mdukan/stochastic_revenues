%REVENUE CALCULATION 2020

function [Agg_SP_Rev20p10,Rev_SP20p10,Agg_Mer_Rev20p10,Rev_Mer20p10,Agg_CfD_Rev20p10,Rev_CfD20p10] = RevCalc_20p10(SimWind_CapFac_UP_Fin_20, SimPrices_20, p10, SimHoursLY, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP20p10 = zeros(SimHoursLY,numberSim);
for i =1:numberSim
    for j=1:SimHoursLY
       if SimPrices_20(j,i)< p10
           Rev_SP20p10(j,i) = p10 * SimWind_CapFac_UP_Fin_20 (j,i); 
       elseif SimPrices_20(j,i)> p10
           Rev_SP20p10(j,i) = SimPrices_20(j,i) * SimWind_CapFac_UP_Fin_20 (j,i); 
       else SimPrices_20(j,i)= p10;
           Rev_SP20p10(j,i) = p10 * SimWind_CapFac_UP_Fin_20 (j,i);
       end
    end
end

Agg_SP_Rev20p10 = sum(Rev_SP20p10);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer20p10 = zeros(SimHoursLY,numberSim);
for i =1:numberSim
    for j=1:SimHoursLY
        Rev_Mer20p10(j,i) = SimPrices_20 (j,i) * SimWind_CapFac_UP_Fin_20 (j,i);
    end
end
    
Agg_Mer_Rev20p10 = sum(Rev_Mer20p10);

%CfD revenues (two-sided)
Rev_CfD20p10 = zeros(SimHoursLY,numberSim);
for i =1:numberSim
    for j=1:SimHoursLY
        Rev_CfD20p10(j,i) = p10 * SimWind_CapFac_UP_Fin_20 (j,i);
    end
end

Agg_CfD_Rev20p10 = sum(Rev_CfD20p10);

end


