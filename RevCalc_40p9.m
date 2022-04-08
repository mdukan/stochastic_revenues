%REVENUE CALCULATION 2020

function [Agg_SP_Rev40p9,Rev_SP40p9,Agg_Mer_Rev40p9,Rev_Mer40p9,Agg_CfD_Rev40p9,Rev_CfD40p9] = RevCalc_40p9(SimWind_CapFac_UP_Fin_40, SimPrices_40, p9, SimHoursLY, numberSim)

%SLIDING PREMIUM revenues (one sided)
Rev_SP40p9 = zeros(SimHoursLY,numberSim);
for i =1:numberSim
    for j=1:SimHoursLY
       if SimPrices_40(j,i)< p9
           Rev_SP40p9(j,i) = p9 * SimWind_CapFac_UP_Fin_40 (j,i); 
       elseif SimPrices_40(j,i)> p9
           Rev_SP40p9(j,i) = SimPrices_40(j,i) * SimWind_CapFac_UP_Fin_40 (j,i); 
       else SimPrices_40(j,i)= p9;
           Rev_SP40p9(j,i) = p9 * SimWind_CapFac_UP_Fin_40 (j,i);
       end
    end
end

Agg_SP_Rev40p9 = sum(Rev_SP40p9);

%MERCHANT revenues (currently takes negative prices)
Rev_Mer40p9 = zeros(SimHoursLY,numberSim);
for i =1:numberSim
    for j=1:SimHoursLY
        Rev_Mer40p9(j,i) = SimPrices_40 (j,i) * SimWind_CapFac_UP_Fin_40 (j,i);
    end
end
    
Agg_Mer_Rev40p9 = sum(Rev_Mer40p9);

%CfD revenues (two-sided)
Rev_CfD40p9 = zeros(SimHoursLY,numberSim);
for i =1:numberSim
    for j=1:SimHoursLY
        Rev_CfD40p9(j,i) = p9 * SimWind_CapFac_UP_Fin_40 (j,i);
    end
end

Agg_CfD_Rev40p9 = sum(Rev_CfD40p9);

end


