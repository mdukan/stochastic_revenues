%REVENUE CALCULATION 2020

function [Agg_SP_Rev20,Rev_SP20,Agg_Mer_Rev20,Rev_Mer20,Agg_CfD_Rev20,Rev_CfD20] = RevCalc_new(SimWind_CapFac_UP_Fin, SimPrices, Price_floor, SimHours, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP20 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
       if SimPrices(j,i)< Price_floor
           Rev_SP20(j,i) = Price_floor * SimWind_CapFac_UP_Fin (j,i); 
       elseif SimPrices(j,i)> Price_floor
           Rev_SP20(j,i) = SimPrices(j,i) * SimWind_CapFac_UP_Fin (j,i); 
       else SimPrices(j,i)= Price_floor;
           Rev_SP20(j,i) = Price_floor * SimWind_CapFac_UP_Fin (j,i);
       end
    end
end

Agg_SP_Rev20 = sum(Rev_SP20);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer20 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_Mer20(j,i) = SimPrices (j,i) * SimWind_CapFac_UP_Fin (j,i);
    end
end
    
Agg_Mer_Rev20 = sum(Rev_Mer20);

%CfD revenues (two-sided)
CfD_floor_ceiling = Price_floor;
Rev_CfD20 = zeros(SimHours,numberSim);
for i =1:numberSim
    for j=1:SimHours
        Rev_CfD20(j,i) = CfD_floor_ceiling * SimWind_CapFac_UP_Fin (j,i);
    end
end

Agg_CfD_Rev20 = sum(Rev_CfD20);

end


