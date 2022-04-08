%DATA CORRECTION: replace and count neg values and values above 1
%this version for leap year!!

function [CountIF_neg,Sum_NegTotal,CountIF_exc1, Sum_exc1Total,SimWind_CapFac_UP_Fin,SimWind_CapFac_UP_Fin_ld,FittedCapFac_mean_fin,...
    HornsRevB_Reshaped_ld,Mean_HornsRevB_2017to2019_ld,DELTA_FIN,Mean_DELTA_FIN,Sum_DELTA_FIN...
    ] = CapFacCorrectionLY(SimWind_CapFac_UP,HornsRevB_2017to2019_LY,SimHours)

neg_val = SimWind_CapFac_UP <0;
exc1_val = SimWind_CapFac_UP >1;
CountIF_neg = sum(neg_val);
Sum_NegTotal = sum(CountIF_neg);
CountIF_exc1 = sum(exc1_val);
Sum_exc1Total = sum(CountIF_exc1);
SimWind_CapFac_UP_Fin = SimWind_CapFac_UP;
SimWind_CapFac_UP_Fin(neg_val) = 0;
SimWind_CapFac_UP_Fin(exc1_val) = 1;

%Calculate mean corrected capacity factors
SimWind_CapFac_UP_Fin_ld = sort(SimWind_CapFac_UP_Fin, 'descend');
FittedCapFac_mean_fin = mean(SimWind_CapFac_UP_Fin_ld')';

%Make an average cap factor ld for HornsRevB for 3 years (2017 to 2019)
%MODIFICATION to regular code: because leap year, use modified HRb data
%MODIFICATION = adding 28th Feb to each year as the leap day
HornsRevB_Reshaped = reshape(HornsRevB_2017to2019_LY,[8784,3]);
HornsRevB_Reshaped_ld = sort(HornsRevB_Reshaped, 'descend');
Mean_HornsRevB_2017to2019_ld = mean(HornsRevB_Reshaped_ld')';

%Size of average delta between fitted and actual capacity factors

DELTA = Mean_HornsRevB_2017to2019_ld - FittedCapFac_mean_fin;
DELTA_FIN = zeros(SimHours,1);
for y =1:1
    for x=1:SimHours
        if DELTA(x,1)<0
            DELTA_FIN(x,1)=DELTA(x,1)*-1;
        else DELTA(x,1)>0;
            DELTA_FIN(x,1)=DELTA(x,1)*1;
        end 
    end
end

%to get a measure of the deviation 
Mean_DELTA_FIN = mean(DELTA_FIN);
Sum_DELTA_FIN = sum(DELTA_FIN);

end


