% loop revenue calculation for different CfD levels

clear all

%add and define variables
addpath ('C:\Mak\000000  MATLAB MAIN FOLDER 000000\MATLAB_outputs\#R001_GenRev_Vol2');
load SimPrices_All;
load SimWind_CapFac_All;

p1 = 50.779;
p2 = 52.057;
p3 = 53.251;
p4 = 54.416;
p5 = 55.532;
p6 = 56.582;
p7 = 57.587;
p8 = 58.532;
p9 = 59.465;
p10 = 60.315;
p11 = 61.128;

SimHours = 8760;
SimHoursLY = 8784;
numberSim = 1000;

%calculate p1 revenues for 2020 to 2050
[Agg_SP_Rev20p1,Rev_SP20p1,Agg_Mer_Rev20p1,Rev_Mer20p1,Agg_CfD_Rev20p1,Rev_CfD20p1] = RevCalc_20p1(SimWind_CapFac_UP_Fin_20, SimPrices_20, p1, SimHoursLY, numberSim);
[Agg_SP_Rev25p1,Rev_SP25p1,Agg_Mer_Rev25p1,Rev_Mer25p1,Agg_CfD_Rev25p1,Rev_CfD25p1] = RevCalc_25p1(SimWind_CapFac_UP_Fin_25, SimPrices_25, p1, SimHours, numberSim);
[Agg_SP_Rev30p1,Rev_SP30p1,Agg_Mer_Rev30p1,Rev_Mer30p1,Agg_CfD_Rev30p1,Rev_CfD30p1] = RevCalc_30p1(SimWind_CapFac_UP_Fin_30, SimPrices_30, p1, SimHours, numberSim);
[Agg_SP_Rev35p1,Rev_SP35p1,Agg_Mer_Rev35p1,Rev_Mer35p1,Agg_CfD_Rev35p1,Rev_CfD35p1] = RevCalc_35p1(SimWind_CapFac_UP_Fin_35, SimPrices_35, p1, SimHours, numberSim);
[Agg_SP_Rev40p1,Rev_SP40p1,Agg_Mer_Rev40p1,Rev_Mer40p1,Agg_CfD_Rev40p1,Rev_CfD40p1] = RevCalc_40p1(SimWind_CapFac_UP_Fin_40, SimPrices_40, p1, SimHoursLY, numberSim);
[Agg_SP_Rev45p1,Rev_SP45p1,Agg_Mer_Rev45p1,Rev_Mer45p1,Agg_CfD_Rev45p1,Rev_CfD45p1] = RevCalc_45p1(SimWind_CapFac_UP_Fin_45, SimPrices_45, p1, SimHours, numberSim);
[Agg_SP_Rev50p1,Rev_SP50p1,Agg_Mer_Rev50p1,Rev_Mer50p1,Agg_CfD_Rev50p1,Rev_CfD50p1] = RevCalc_50p1(SimWind_CapFac_UP_Fin_50, SimPrices_50, p1, SimHours, numberSim);

[CfD_All_p1,SP_All_p1,Mer_All_p1,CfD_Delta_p1,CfD_Rev_21_49_p1,CfD_NonSim_Years_p1,CfD_Rev_Mid_p1,...
    CfD_Rev_Fin_p1, SP_Delta_p1,SP_Rev_21_49_p1,SP_NonSimYears_p1, SP_Rev_Mid_p1,SP_Rev_Fin_p1, Mer_Delta_p1,Mer_Rev_21_49_p1,...
    Mer_NonSimYears_p1,Mer_Rev_Mid_p1,Mer_Rev_Fin_p1,MeanCfD_p1,MeanSP_p1,MeanMer_p1] = AggRevP1(Agg_CfD_Rev20p1,Agg_CfD_Rev25p1,Agg_CfD_Rev30p1,Agg_CfD_Rev35p1,...
    Agg_CfD_Rev40p1,Agg_CfD_Rev45p1,Agg_CfD_Rev50p1,Agg_SP_Rev20p1,Agg_SP_Rev25p1,Agg_SP_Rev30p1,Agg_SP_Rev35p1,...
     Agg_SP_Rev40p1,Agg_SP_Rev45p1,Agg_SP_Rev50p1,Agg_Mer_Rev20p1,Agg_Mer_Rev25p1,Agg_Mer_Rev30p1,Agg_Mer_Rev35p1,...
    Agg_Mer_Rev40p1,Agg_Mer_Rev45p1,Agg_Mer_Rev50p1);

%calculate p2 revenues for 2020 to 2050
[Agg_SP_Rev20p2,Rev_SP20p2,Agg_Mer_Rev20p2,Rev_Mer20p2,Agg_CfD_Rev20p2,Rev_CfD20p2] = RevCalc_20p2(SimWind_CapFac_UP_Fin_20, SimPrices_20, p2, SimHoursLY, numberSim);
[Agg_SP_Rev25p2,Rev_SP25p2,Agg_Mer_Rev25p2,Rev_Mer25p2,Agg_CfD_Rev25p2,Rev_CfD25p2] = RevCalc_25p2(SimWind_CapFac_UP_Fin_25, SimPrices_25, p2, SimHours, numberSim);
[Agg_SP_Rev30p2,Rev_SP30p2,Agg_Mer_Rev30p2,Rev_Mer30p2,Agg_CfD_Rev30p2,Rev_CfD30p2] = RevCalc_30p2(SimWind_CapFac_UP_Fin_30, SimPrices_30, p2, SimHours, numberSim);
[Agg_SP_Rev35p2,Rev_SP35p2,Agg_Mer_Rev35p2,Rev_Mer35p2,Agg_CfD_Rev35p2,Rev_CfD35p2] = RevCalc_35p2(SimWind_CapFac_UP_Fin_35, SimPrices_35, p2, SimHours, numberSim);
[Agg_SP_Rev40p2,Rev_SP40p2,Agg_Mer_Rev40p2,Rev_Mer40p2,Agg_CfD_Rev40p2,Rev_CfD40p2] = RevCalc_40p2(SimWind_CapFac_UP_Fin_40, SimPrices_40, p2, SimHoursLY, numberSim);
[Agg_SP_Rev45p2,Rev_SP45p2,Agg_Mer_Rev45p2,Rev_Mer45p2,Agg_CfD_Rev45p2,Rev_CfD45p2] = RevCalc_45p2(SimWind_CapFac_UP_Fin_45, SimPrices_45, p2, SimHours, numberSim);
[Agg_SP_Rev50p2,Rev_SP50p2,Agg_Mer_Rev50p2,Rev_Mer50p2,Agg_CfD_Rev50p2,Rev_CfD50p2] = RevCalc_50p2(SimWind_CapFac_UP_Fin_50, SimPrices_50, p2, SimHours, numberSim);

[CfD_All_p2,SP_All_p2,Mer_All_p2,CfD_Delta_p2,CfD_Rev_21_49_p2,CfD_NonSim_Years_p2,CfD_Rev_Mid_p2,...
    CfD_Rev_Fin_p2, SP_Delta_p2,SP_Rev_21_49_p2,SP_NonSimYears_p2, SP_Rev_Mid_p2,SP_Rev_Fin_p2, Mer_Delta_p2,Mer_Rev_21_49_p2,...
    Mer_NonSimYears_p2,Mer_Rev_Mid_p2,Mer_Rev_Fin_p2,MeanCfD_p2,MeanSP_p2,MeanMer_p2] = AggRevP2(Agg_CfD_Rev20p2,Agg_CfD_Rev25p2,Agg_CfD_Rev30p2,Agg_CfD_Rev35p2,...
    Agg_CfD_Rev40p2,Agg_CfD_Rev45p2,Agg_CfD_Rev50p2,Agg_SP_Rev20p2,Agg_SP_Rev25p2,Agg_SP_Rev30p2,Agg_SP_Rev35p2,...
     Agg_SP_Rev40p2,Agg_SP_Rev45p2,Agg_SP_Rev50p2,Agg_Mer_Rev20p2,Agg_Mer_Rev25p2,Agg_Mer_Rev30p2,Agg_Mer_Rev35p2,...
    Agg_Mer_Rev40p2,Agg_Mer_Rev45p2,Agg_Mer_Rev50p2);

%calculate p3 revenues for 2020 to 2050
[Agg_SP_Rev20p3,Rev_SP20p3,Agg_Mer_Rev20p3,Rev_Mer20p3,Agg_CfD_Rev20p3,Rev_CfD20p3] = RevCalc_20p3(SimWind_CapFac_UP_Fin_20, SimPrices_20, p3, SimHoursLY, numberSim);
[Agg_SP_Rev25p3,Rev_SP25p3,Agg_Mer_Rev25p3,Rev_Mer25p3,Agg_CfD_Rev25p3,Rev_CfD25p3] = RevCalc_25p3(SimWind_CapFac_UP_Fin_25, SimPrices_25, p3, SimHours, numberSim);
[Agg_SP_Rev30p3,Rev_SP30p3,Agg_Mer_Rev30p3,Rev_Mer30p3,Agg_CfD_Rev30p3,Rev_CfD30p3] = RevCalc_30p3(SimWind_CapFac_UP_Fin_30, SimPrices_30, p3, SimHours, numberSim);
[Agg_SP_Rev35p3,Rev_SP35p3,Agg_Mer_Rev35p3,Rev_Mer35p3,Agg_CfD_Rev35p3,Rev_CfD35p3] = RevCalc_35p3(SimWind_CapFac_UP_Fin_35, SimPrices_35, p3, SimHours, numberSim);
[Agg_SP_Rev40p3,Rev_SP40p3,Agg_Mer_Rev40p3,Rev_Mer40p3,Agg_CfD_Rev40p3,Rev_CfD40p3] = RevCalc_40p3(SimWind_CapFac_UP_Fin_40, SimPrices_40, p3, SimHoursLY, numberSim);
[Agg_SP_Rev45p3,Rev_SP45p3,Agg_Mer_Rev45p3,Rev_Mer45p3,Agg_CfD_Rev45p3,Rev_CfD45p3] = RevCalc_45p3(SimWind_CapFac_UP_Fin_45, SimPrices_45, p3, SimHours, numberSim);
[Agg_SP_Rev50p3,Rev_SP50p3,Agg_Mer_Rev50p3,Rev_Mer50p3,Agg_CfD_Rev50p3,Rev_CfD50p3] = RevCalc_50p3(SimWind_CapFac_UP_Fin_50, SimPrices_50, p3, SimHours, numberSim);

[CfD_All_p3,SP_All_p3,Mer_All_p3,CfD_Delta_p3,CfD_Rev_21_49_p3,CfD_NonSim_Years_p3,CfD_Rev_Mid_p3,...
    CfD_Rev_Fin_p3, SP_Delta_p3,SP_Rev_21_49_p3,SP_NonSimYears_p3, SP_Rev_Mid_p3,SP_Rev_Fin_p3, Mer_Delta_p3,Mer_Rev_21_49_p3,...
    Mer_NonSimYears_p3,Mer_Rev_Mid_p3,Mer_Rev_Fin_p3,MeanCfD_p3,MeanSP_p3,MeanMer_p3] = AggRevP3(Agg_CfD_Rev20p3,Agg_CfD_Rev25p3,Agg_CfD_Rev30p3,Agg_CfD_Rev35p3,...
    Agg_CfD_Rev40p3,Agg_CfD_Rev45p3,Agg_CfD_Rev50p3,Agg_SP_Rev20p3,Agg_SP_Rev25p3,Agg_SP_Rev30p3,Agg_SP_Rev35p3,...
     Agg_SP_Rev40p3,Agg_SP_Rev45p3,Agg_SP_Rev50p3,Agg_Mer_Rev20p3,Agg_Mer_Rev25p3,Agg_Mer_Rev30p3,Agg_Mer_Rev35p3,...
    Agg_Mer_Rev40p3,Agg_Mer_Rev45p3,Agg_Mer_Rev50p3);

%calculate p4 revenues for 2020 to 2050
[Agg_SP_Rev20p4,Rev_SP20p4,Agg_Mer_Rev20p4,Rev_Mer20p4,Agg_CfD_Rev20p4,Rev_CfD20p4] = RevCalc_20p4(SimWind_CapFac_UP_Fin_20, SimPrices_20, p4, SimHoursLY, numberSim);
[Agg_SP_Rev25p4,Rev_SP25p4,Agg_Mer_Rev25p4,Rev_Mer25p4,Agg_CfD_Rev25p4,Rev_CfD25p4] = RevCalc_25p4(SimWind_CapFac_UP_Fin_25, SimPrices_25, p4, SimHours, numberSim);
[Agg_SP_Rev30p4,Rev_SP30p4,Agg_Mer_Rev30p4,Rev_Mer30p4,Agg_CfD_Rev30p4,Rev_CfD30p4] = RevCalc_30p4(SimWind_CapFac_UP_Fin_30, SimPrices_30, p4, SimHours, numberSim);
[Agg_SP_Rev35p4,Rev_SP35p4,Agg_Mer_Rev35p4,Rev_Mer35p4,Agg_CfD_Rev35p4,Rev_CfD35p4] = RevCalc_35p4(SimWind_CapFac_UP_Fin_35, SimPrices_35, p4, SimHours, numberSim);
[Agg_SP_Rev40p4,Rev_SP40p4,Agg_Mer_Rev40p4,Rev_Mer40p4,Agg_CfD_Rev40p4,Rev_CfD40p4] = RevCalc_40p4(SimWind_CapFac_UP_Fin_40, SimPrices_40, p4, SimHoursLY, numberSim);
[Agg_SP_Rev45p4,Rev_SP45p4,Agg_Mer_Rev45p4,Rev_Mer45p4,Agg_CfD_Rev45p4,Rev_CfD45p4] = RevCalc_45p4(SimWind_CapFac_UP_Fin_45, SimPrices_45, p4, SimHours, numberSim);
[Agg_SP_Rev50p4,Rev_SP50p4,Agg_Mer_Rev50p4,Rev_Mer50p4,Agg_CfD_Rev50p4,Rev_CfD50p4] = RevCalc_50p4(SimWind_CapFac_UP_Fin_50, SimPrices_50, p4, SimHours, numberSim);

[CfD_All_p4,SP_All_p4,Mer_All_p4,CfD_Delta_p4,CfD_Rev_21_49_p4,CfD_NonSim_Years_p4,CfD_Rev_Mid_p4,...
    CfD_Rev_Fin_p4, SP_Delta_p4,SP_Rev_21_49_p4,SP_NonSimYears_p4, SP_Rev_Mid_p4,SP_Rev_Fin_p4, Mer_Delta_p4,Mer_Rev_21_49_p4,...
    Mer_NonSimYears_p4,Mer_Rev_Mid_p4,Mer_Rev_Fin_p4,MeanCfD_p4,MeanSP_p4,MeanMer_p4] = AggRevP4(Agg_CfD_Rev20p4,Agg_CfD_Rev25p4,Agg_CfD_Rev30p4,Agg_CfD_Rev35p4,...
    Agg_CfD_Rev40p4,Agg_CfD_Rev45p4,Agg_CfD_Rev50p4,Agg_SP_Rev20p4,Agg_SP_Rev25p4,Agg_SP_Rev30p4,Agg_SP_Rev35p4,...
     Agg_SP_Rev40p4,Agg_SP_Rev45p4,Agg_SP_Rev50p4,Agg_Mer_Rev20p4,Agg_Mer_Rev25p4,Agg_Mer_Rev30p4,Agg_Mer_Rev35p4,...
    Agg_Mer_Rev40p4,Agg_Mer_Rev45p4,Agg_Mer_Rev50p4);

%calculate p5 revenues for 2020 to 2050

[Agg_SP_Rev20p5,Rev_SP20p5,Agg_Mer_Rev20p5,Rev_Mer20p5,Agg_CfD_Rev20p5,Rev_CfD20p5] = RevCalc_20p5(SimWind_CapFac_UP_Fin_20, SimPrices_20, p5, SimHoursLY, numberSim);
[Agg_SP_Rev25p5,Rev_SP25p5,Agg_Mer_Rev25p5,Rev_Mer25p5,Agg_CfD_Rev25p5,Rev_CfD25p5] = RevCalc_25p5(SimWind_CapFac_UP_Fin_25, SimPrices_25, p5, SimHours, numberSim);
[Agg_SP_Rev30p5,Rev_SP30p5,Agg_Mer_Rev30p5,Rev_Mer30p5,Agg_CfD_Rev30p5,Rev_CfD30p5] = RevCalc_30p5(SimWind_CapFac_UP_Fin_30, SimPrices_30, p5, SimHours, numberSim);
[Agg_SP_Rev35p5,Rev_SP35p5,Agg_Mer_Rev35p5,Rev_Mer35p5,Agg_CfD_Rev35p5,Rev_CfD35p5] = RevCalc_35p5(SimWind_CapFac_UP_Fin_35, SimPrices_35, p5, SimHours, numberSim);
[Agg_SP_Rev40p5,Rev_SP40p5,Agg_Mer_Rev40p5,Rev_Mer40p5,Agg_CfD_Rev40p5,Rev_CfD40p5] = RevCalc_40p5(SimWind_CapFac_UP_Fin_40, SimPrices_40, p5, SimHoursLY, numberSim);
[Agg_SP_Rev45p5,Rev_SP45p5,Agg_Mer_Rev45p5,Rev_Mer45p5,Agg_CfD_Rev45p5,Rev_CfD45p5] = RevCalc_45p5(SimWind_CapFac_UP_Fin_45, SimPrices_45, p5, SimHours, numberSim);
[Agg_SP_Rev50p5,Rev_SP50p5,Agg_Mer_Rev50p5,Rev_Mer50p5,Agg_CfD_Rev50p5,Rev_CfD50p5] = RevCalc_50p5(SimWind_CapFac_UP_Fin_50, SimPrices_50, p5, SimHours, numberSim);

[CfD_All_p5,SP_All_p5,Mer_All_p5,CfD_Delta_p5,CfD_Rev_21_49_p5,CfD_NonSim_Years_p5,CfD_Rev_Mid_p5,...
    CfD_Rev_Fin_p5, SP_Delta_p5,SP_Rev_21_49_p5,SP_NonSimYears_p5, SP_Rev_Mid_p5,SP_Rev_Fin_p5, Mer_Delta_p5,Mer_Rev_21_49_p5,...
    Mer_NonSimYears_p5,Mer_Rev_Mid_p5,Mer_Rev_Fin_p5,MeanCfD_p5,MeanSP_p5,MeanMer_p5] = AggRevP5(Agg_CfD_Rev20p5,Agg_CfD_Rev25p5,Agg_CfD_Rev30p5,Agg_CfD_Rev35p5,...
    Agg_CfD_Rev40p5,Agg_CfD_Rev45p5,Agg_CfD_Rev50p5,Agg_SP_Rev20p5,Agg_SP_Rev25p5,Agg_SP_Rev30p5,Agg_SP_Rev35p5,...
     Agg_SP_Rev40p5,Agg_SP_Rev45p5,Agg_SP_Rev50p5,Agg_Mer_Rev20p5,Agg_Mer_Rev25p5,Agg_Mer_Rev30p5,Agg_Mer_Rev35p5,...
    Agg_Mer_Rev40p5,Agg_Mer_Rev45p5,Agg_Mer_Rev50p5);

%calculate p6 revenues for 2020 to 2050

[Agg_SP_Rev20p6,Rev_SP20p6,Agg_Mer_Rev20p6,Rev_Mer20p6,Agg_CfD_Rev20p6,Rev_CfD20p6] = RevCalc_20p6(SimWind_CapFac_UP_Fin_20, SimPrices_20, p6, SimHoursLY, numberSim);
[Agg_SP_Rev25p6,Rev_SP25p6,Agg_Mer_Rev25p6,Rev_Mer25p6,Agg_CfD_Rev25p6,Rev_CfD25p6] = RevCalc_25p6(SimWind_CapFac_UP_Fin_25, SimPrices_25, p6, SimHours, numberSim);
[Agg_SP_Rev30p6,Rev_SP30p6,Agg_Mer_Rev30p6,Rev_Mer30p6,Agg_CfD_Rev30p6,Rev_CfD30p6] = RevCalc_30p6(SimWind_CapFac_UP_Fin_30, SimPrices_30, p6, SimHours, numberSim);
[Agg_SP_Rev35p6,Rev_SP35p6,Agg_Mer_Rev35p6,Rev_Mer35p6,Agg_CfD_Rev35p6,Rev_CfD35p6] = RevCalc_35p6(SimWind_CapFac_UP_Fin_35, SimPrices_35, p6, SimHours, numberSim);
[Agg_SP_Rev40p6,Rev_SP40p6,Agg_Mer_Rev40p6,Rev_Mer40p6,Agg_CfD_Rev40p6,Rev_CfD40p6] = RevCalc_40p6(SimWind_CapFac_UP_Fin_40, SimPrices_40, p6, SimHoursLY, numberSim);
[Agg_SP_Rev45p6,Rev_SP45p6,Agg_Mer_Rev45p6,Rev_Mer45p6,Agg_CfD_Rev45p6,Rev_CfD45p6] = RevCalc_45p6(SimWind_CapFac_UP_Fin_45, SimPrices_45, p6, SimHours, numberSim);
[Agg_SP_Rev50p6,Rev_SP50p6,Agg_Mer_Rev50p6,Rev_Mer50p6,Agg_CfD_Rev50p6,Rev_CfD50p6] = RevCalc_50p6(SimWind_CapFac_UP_Fin_50, SimPrices_50, p6, SimHours, numberSim);

[CfD_All_p6,SP_All_p6,Mer_All_p6,CfD_Delta_p6,CfD_Rev_21_49_p6,CfD_NonSim_Years_p6,CfD_Rev_Mid_p6,...
    CfD_Rev_Fin_p6, SP_Delta_p6,SP_Rev_21_49_p6,SP_NonSimYears_p6, SP_Rev_Mid_p6,SP_Rev_Fin_p6, Mer_Delta_p6,Mer_Rev_21_49_p6,...
    Mer_NonSimYears_p6,Mer_Rev_Mid_p6,Mer_Rev_Fin_p6,MeanCfD_p6,MeanSP_p6,MeanMer_p6] = AggRevP6(Agg_CfD_Rev20p6,Agg_CfD_Rev25p6,Agg_CfD_Rev30p6,Agg_CfD_Rev35p6,...
    Agg_CfD_Rev40p6,Agg_CfD_Rev45p6,Agg_CfD_Rev50p6,Agg_SP_Rev20p6,Agg_SP_Rev25p6,Agg_SP_Rev30p6,Agg_SP_Rev35p6,...
     Agg_SP_Rev40p6,Agg_SP_Rev45p6,Agg_SP_Rev50p6,Agg_Mer_Rev20p6,Agg_Mer_Rev25p6,Agg_Mer_Rev30p6,Agg_Mer_Rev35p6,...
    Agg_Mer_Rev40p6,Agg_Mer_Rev45p6,Agg_Mer_Rev50p6);

%calculate p7 revenues for 2020 to 2050

[Agg_SP_Rev20p7,Rev_SP20p7,Agg_Mer_Rev20p7,Rev_Mer20p7,Agg_CfD_Rev20p7,Rev_CfD20p7] = RevCalc_20p7(SimWind_CapFac_UP_Fin_20, SimPrices_20, p7, SimHoursLY, numberSim);
[Agg_SP_Rev25p7,Rev_SP25p7,Agg_Mer_Rev25p7,Rev_Mer25p7,Agg_CfD_Rev25p7,Rev_CfD25p7] = RevCalc_25p7(SimWind_CapFac_UP_Fin_25, SimPrices_25, p7, SimHours, numberSim);
[Agg_SP_Rev30p7,Rev_SP30p7,Agg_Mer_Rev30p7,Rev_Mer30p7,Agg_CfD_Rev30p7,Rev_CfD30p7] = RevCalc_30p7(SimWind_CapFac_UP_Fin_30, SimPrices_30, p7, SimHours, numberSim);
[Agg_SP_Rev35p7,Rev_SP35p7,Agg_Mer_Rev35p7,Rev_Mer35p7,Agg_CfD_Rev35p7,Rev_CfD35p7] = RevCalc_35p7(SimWind_CapFac_UP_Fin_35, SimPrices_35, p7, SimHours, numberSim);
[Agg_SP_Rev40p7,Rev_SP40p7,Agg_Mer_Rev40p7,Rev_Mer40p7,Agg_CfD_Rev40p7,Rev_CfD40p7] = RevCalc_40p7(SimWind_CapFac_UP_Fin_40, SimPrices_40, p7, SimHoursLY, numberSim);
[Agg_SP_Rev45p7,Rev_SP45p7,Agg_Mer_Rev45p7,Rev_Mer45p7,Agg_CfD_Rev45p7,Rev_CfD45p7] = RevCalc_45p7(SimWind_CapFac_UP_Fin_45, SimPrices_45, p7, SimHours, numberSim);
[Agg_SP_Rev50p7,Rev_SP50p7,Agg_Mer_Rev50p7,Rev_Mer50p7,Agg_CfD_Rev50p7,Rev_CfD50p7] = RevCalc_50p7(SimWind_CapFac_UP_Fin_50, SimPrices_50, p7, SimHours, numberSim);

[CfD_All_p7,SP_All_p7,Mer_All_p7,CfD_Delta_p7,CfD_Rev_21_49_p7,CfD_NonSim_Years_p7,CfD_Rev_Mid_p7,...
    CfD_Rev_Fin_p7, SP_Delta_p7,SP_Rev_21_49_p7,SP_NonSimYears_p7, SP_Rev_Mid_p7,SP_Rev_Fin_p7, Mer_Delta_p7,Mer_Rev_21_49_p7,...
    Mer_NonSimYears_p7,Mer_Rev_Mid_p7,Mer_Rev_Fin_p7,MeanCfD_p7,MeanSP_p7,MeanMer_p7] = AggRevP7(Agg_CfD_Rev20p7,Agg_CfD_Rev25p7,Agg_CfD_Rev30p7,Agg_CfD_Rev35p7,...
    Agg_CfD_Rev40p7,Agg_CfD_Rev45p7,Agg_CfD_Rev50p7,Agg_SP_Rev20p7,Agg_SP_Rev25p7,Agg_SP_Rev30p7,Agg_SP_Rev35p7,...
     Agg_SP_Rev40p7,Agg_SP_Rev45p7,Agg_SP_Rev50p7,Agg_Mer_Rev20p7,Agg_Mer_Rev25p7,Agg_Mer_Rev30p7,Agg_Mer_Rev35p7,...
    Agg_Mer_Rev40p7,Agg_Mer_Rev45p7,Agg_Mer_Rev50p7);

%calculate p8 revenues for 2020 to 2050

[Agg_SP_Rev20p8,Rev_SP20p8,Agg_Mer_Rev20p8,Rev_Mer20p8,Agg_CfD_Rev20p8,Rev_CfD20p8] = RevCalc_20p8(SimWind_CapFac_UP_Fin_20, SimPrices_20, p8, SimHoursLY, numberSim);
[Agg_SP_Rev25p8,Rev_SP25p8,Agg_Mer_Rev25p8,Rev_Mer25p8,Agg_CfD_Rev25p8,Rev_CfD25p8] = RevCalc_25p8(SimWind_CapFac_UP_Fin_25, SimPrices_25, p8, SimHours, numberSim);
[Agg_SP_Rev30p8,Rev_SP30p8,Agg_Mer_Rev30p8,Rev_Mer30p8,Agg_CfD_Rev30p8,Rev_CfD30p8] = RevCalc_30p8(SimWind_CapFac_UP_Fin_30, SimPrices_30, p8, SimHours, numberSim);
[Agg_SP_Rev35p8,Rev_SP35p8,Agg_Mer_Rev35p8,Rev_Mer35p8,Agg_CfD_Rev35p8,Rev_CfD35p8] = RevCalc_35p8(SimWind_CapFac_UP_Fin_35, SimPrices_35, p8, SimHours, numberSim);
[Agg_SP_Rev40p8,Rev_SP40p8,Agg_Mer_Rev40p8,Rev_Mer40p8,Agg_CfD_Rev40p8,Rev_CfD40p8] = RevCalc_40p8(SimWind_CapFac_UP_Fin_40, SimPrices_40, p8, SimHoursLY, numberSim);
[Agg_SP_Rev45p8,Rev_SP45p8,Agg_Mer_Rev45p8,Rev_Mer45p8,Agg_CfD_Rev45p8,Rev_CfD45p8] = RevCalc_45p8(SimWind_CapFac_UP_Fin_45, SimPrices_45, p8, SimHours, numberSim);
[Agg_SP_Rev50p8,Rev_SP50p8,Agg_Mer_Rev50p8,Rev_Mer50p8,Agg_CfD_Rev50p8,Rev_CfD50p8] = RevCalc_50p8(SimWind_CapFac_UP_Fin_50, SimPrices_50, p8, SimHours, numberSim);

[CfD_All_p8,SP_All_p8,Mer_All_p8,CfD_Delta_p8,CfD_Rev_21_49_p8,CfD_NonSim_Years_p8,CfD_Rev_Mid_p8,...
    CfD_Rev_Fin_p8, SP_Delta_p8,SP_Rev_21_49_p8,SP_NonSimYears_p8, SP_Rev_Mid_p8,SP_Rev_Fin_p8, Mer_Delta_p8,Mer_Rev_21_49_p8,...
    Mer_NonSimYears_p8,Mer_Rev_Mid_p8,Mer_Rev_Fin_p8,MeanCfD_p8,MeanSP_p8,MeanMer_p8] = AggRevP8(Agg_CfD_Rev20p8,Agg_CfD_Rev25p8,Agg_CfD_Rev30p8,Agg_CfD_Rev35p8,...
    Agg_CfD_Rev40p8,Agg_CfD_Rev45p8,Agg_CfD_Rev50p8,Agg_SP_Rev20p8,Agg_SP_Rev25p8,Agg_SP_Rev30p8,Agg_SP_Rev35p8,...
     Agg_SP_Rev40p8,Agg_SP_Rev45p8,Agg_SP_Rev50p8,Agg_Mer_Rev20p8,Agg_Mer_Rev25p8,Agg_Mer_Rev30p8,Agg_Mer_Rev35p8,...
    Agg_Mer_Rev40p8,Agg_Mer_Rev45p8,Agg_Mer_Rev50p8);

%calculate p9 revenues for 2020 to 2050

[Agg_SP_Rev20p9,Rev_SP20p9,Agg_Mer_Rev20p9,Rev_Mer20p9,Agg_CfD_Rev20p9,Rev_CfD20p9] = RevCalc_20p9(SimWind_CapFac_UP_Fin_20, SimPrices_20, p9, SimHoursLY, numberSim);
[Agg_SP_Rev25p9,Rev_SP25p9,Agg_Mer_Rev25p9,Rev_Mer25p9,Agg_CfD_Rev25p9,Rev_CfD25p9] = RevCalc_25p9(SimWind_CapFac_UP_Fin_25, SimPrices_25, p9, SimHours, numberSim);
[Agg_SP_Rev30p9,Rev_SP30p9,Agg_Mer_Rev30p9,Rev_Mer30p9,Agg_CfD_Rev30p9,Rev_CfD30p9] = RevCalc_30p9(SimWind_CapFac_UP_Fin_30, SimPrices_30, p9, SimHours, numberSim);
[Agg_SP_Rev35p9,Rev_SP35p9,Agg_Mer_Rev35p9,Rev_Mer35p9,Agg_CfD_Rev35p9,Rev_CfD35p9] = RevCalc_35p9(SimWind_CapFac_UP_Fin_35, SimPrices_35, p9, SimHours, numberSim);
[Agg_SP_Rev40p9,Rev_SP40p9,Agg_Mer_Rev40p9,Rev_Mer40p9,Agg_CfD_Rev40p9,Rev_CfD40p9] = RevCalc_40p9(SimWind_CapFac_UP_Fin_40, SimPrices_40, p9, SimHoursLY, numberSim);
[Agg_SP_Rev45p9,Rev_SP45p9,Agg_Mer_Rev45p9,Rev_Mer45p9,Agg_CfD_Rev45p9,Rev_CfD45p9] = RevCalc_45p9(SimWind_CapFac_UP_Fin_45, SimPrices_45, p9, SimHours, numberSim);
[Agg_SP_Rev50p9,Rev_SP50p9,Agg_Mer_Rev50p9,Rev_Mer50p9,Agg_CfD_Rev50p9,Rev_CfD50p9] = RevCalc_50p9(SimWind_CapFac_UP_Fin_50, SimPrices_50, p9, SimHours, numberSim);

[CfD_All_p9,SP_All_p9,Mer_All_p9,CfD_Delta_p9,CfD_Rev_21_49_p9,CfD_NonSim_Years_p9,CfD_Rev_Mid_p9,...
    CfD_Rev_Fin_p9, SP_Delta_p9,SP_Rev_21_49_p9,SP_NonSimYears_p9, SP_Rev_Mid_p9,SP_Rev_Fin_p9, Mer_Delta_p9,Mer_Rev_21_49_p9,...
    Mer_NonSimYears_p9,Mer_Rev_Mid_p9,Mer_Rev_Fin_p9,MeanCfD_p9,MeanSP_p9,MeanMer_p9] = AggRevP9(Agg_CfD_Rev20p9,Agg_CfD_Rev25p9,Agg_CfD_Rev30p9,Agg_CfD_Rev35p9,...
    Agg_CfD_Rev40p9,Agg_CfD_Rev45p9,Agg_CfD_Rev50p9,Agg_SP_Rev20p9,Agg_SP_Rev25p9,Agg_SP_Rev30p9,Agg_SP_Rev35p9,...
     Agg_SP_Rev40p9,Agg_SP_Rev45p9,Agg_SP_Rev50p9,Agg_Mer_Rev20p9,Agg_Mer_Rev25p9,Agg_Mer_Rev30p9,Agg_Mer_Rev35p9,...
    Agg_Mer_Rev40p9,Agg_Mer_Rev45p9,Agg_Mer_Rev50p9);

%calculate p10 revenues for 2020 to 2050

[Agg_SP_Rev20p10,Rev_SP20p10,Agg_Mer_Rev20p10,Rev_Mer20p10,Agg_CfD_Rev20p10,Rev_CfD20p10] = RevCalc_20p10(SimWind_CapFac_UP_Fin_20, SimPrices_20, p10, SimHoursLY, numberSim);
[Agg_SP_Rev25p10,Rev_SP25p10,Agg_Mer_Rev25p10,Rev_Mer25p10,Agg_CfD_Rev25p10,Rev_CfD25p10] = RevCalc_25p10(SimWind_CapFac_UP_Fin_25, SimPrices_25, p10, SimHours, numberSim);
[Agg_SP_Rev30p10,Rev_SP30p10,Agg_Mer_Rev30p10,Rev_Mer30p10,Agg_CfD_Rev30p10,Rev_CfD30p10] = RevCalc_30p10(SimWind_CapFac_UP_Fin_30, SimPrices_30, p10, SimHours, numberSim);
[Agg_SP_Rev35p10,Rev_SP35p10,Agg_Mer_Rev35p10,Rev_Mer35p10,Agg_CfD_Rev35p10,Rev_CfD35p10] = RevCalc_35p10(SimWind_CapFac_UP_Fin_35, SimPrices_35, p10, SimHours, numberSim);
[Agg_SP_Rev40p10,Rev_SP40p10,Agg_Mer_Rev40p10,Rev_Mer40p10,Agg_CfD_Rev40p10,Rev_CfD40p10] = RevCalc_40p10(SimWind_CapFac_UP_Fin_40, SimPrices_40, p10, SimHoursLY, numberSim);
[Agg_SP_Rev45p10,Rev_SP45p10,Agg_Mer_Rev45p10,Rev_Mer45p10,Agg_CfD_Rev45p10,Rev_CfD45p10] = RevCalc_45p10(SimWind_CapFac_UP_Fin_45, SimPrices_45, p10, SimHours, numberSim);
[Agg_SP_Rev50p10,Rev_SP50p10,Agg_Mer_Rev50p10,Rev_Mer50p10,Agg_CfD_Rev50p10,Rev_CfD50p10] = RevCalc_50p10(SimWind_CapFac_UP_Fin_50, SimPrices_50, p10, SimHours, numberSim);

[CfD_All_p10,SP_All_p10,Mer_All_p10,CfD_Delta_p10,CfD_Rev_21_49_p10,CfD_NonSim_Years_p10,CfD_Rev_Mid_p10,...
    CfD_Rev_Fin_p10, SP_Delta_p10,SP_Rev_21_49_p10,SP_NonSimYears_p10, SP_Rev_Mid_p10,SP_Rev_Fin_p10, Mer_Delta_p10,Mer_Rev_21_49_p10,...
    Mer_NonSimYears_p10,Mer_Rev_Mid_p10,Mer_Rev_Fin_p10,MeanCfD_p10,MeanSP_p10,MeanMer_p10] = AggRevP10(Agg_CfD_Rev20p10,Agg_CfD_Rev25p10,Agg_CfD_Rev30p10,Agg_CfD_Rev35p10,...
    Agg_CfD_Rev40p10,Agg_CfD_Rev45p10,Agg_CfD_Rev50p10,Agg_SP_Rev20p10,Agg_SP_Rev25p10,Agg_SP_Rev30p10,Agg_SP_Rev35p10,...
     Agg_SP_Rev40p10,Agg_SP_Rev45p10,Agg_SP_Rev50p10,Agg_Mer_Rev20p10,Agg_Mer_Rev25p10,Agg_Mer_Rev30p10,Agg_Mer_Rev35p10,...
    Agg_Mer_Rev40p10,Agg_Mer_Rev45p10,Agg_Mer_Rev50p10);

%calculate p11 revenues for 2020 to 2050

[Agg_SP_Rev20p11,Rev_SP20p11,Agg_Mer_Rev20p11,Rev_Mer20p11,Agg_CfD_Rev20p11,Rev_CfD20p11] = RevCalc_20p11(SimWind_CapFac_UP_Fin_20, SimPrices_20, p11, SimHoursLY, numberSim);
[Agg_SP_Rev25p11,Rev_SP25p11,Agg_Mer_Rev25p11,Rev_Mer25p11,Agg_CfD_Rev25p11,Rev_CfD25p11] = RevCalc_25p11(SimWind_CapFac_UP_Fin_25, SimPrices_25, p11, SimHours, numberSim);
[Agg_SP_Rev30p11,Rev_SP30p11,Agg_Mer_Rev30p11,Rev_Mer30p11,Agg_CfD_Rev30p11,Rev_CfD30p11] = RevCalc_30p11(SimWind_CapFac_UP_Fin_30, SimPrices_30, p11, SimHours, numberSim);
[Agg_SP_Rev35p11,Rev_SP35p11,Agg_Mer_Rev35p11,Rev_Mer35p11,Agg_CfD_Rev35p11,Rev_CfD35p11] = RevCalc_35p11(SimWind_CapFac_UP_Fin_35, SimPrices_35, p11, SimHours, numberSim);
[Agg_SP_Rev40p11,Rev_SP40p11,Agg_Mer_Rev40p11,Rev_Mer40p11,Agg_CfD_Rev40p11,Rev_CfD40p11] = RevCalc_40p11(SimWind_CapFac_UP_Fin_40, SimPrices_40, p11, SimHoursLY, numberSim);
[Agg_SP_Rev45p11,Rev_SP45p11,Agg_Mer_Rev45p11,Rev_Mer45p11,Agg_CfD_Rev45p11,Rev_CfD45p11] = RevCalc_45p11(SimWind_CapFac_UP_Fin_45, SimPrices_45, p11, SimHours, numberSim);
[Agg_SP_Rev50p11,Rev_SP50p11,Agg_Mer_Rev50p11,Rev_Mer50p11,Agg_CfD_Rev50p11,Rev_CfD50p11] = RevCalc_50p11(SimWind_CapFac_UP_Fin_50, SimPrices_50, p11, SimHours, numberSim);

[CfD_All_p11,SP_All_p11,Mer_All_p11,CfD_Delta_p11,CfD_Rev_21_49_p11,CfD_NonSim_Years_p11,CfD_Rev_Mid_p11,...
    CfD_Rev_Fin_p11, SP_Delta_p11,SP_Rev_21_49_p11,SP_NonSimYears_p11, SP_Rev_Mid_p11,SP_Rev_Fin_p11, Mer_Delta_p11,Mer_Rev_21_49_p11,...
    Mer_NonSimYears_p11,Mer_Rev_Mid_p11,Mer_Rev_Fin_p11,MeanCfD_p11,MeanSP_p11,MeanMer_p11] = AggRevP11(Agg_CfD_Rev20p11,Agg_CfD_Rev25p11,Agg_CfD_Rev30p11,Agg_CfD_Rev35p11,...
    Agg_CfD_Rev40p11,Agg_CfD_Rev45p11,Agg_CfD_Rev50p11,Agg_SP_Rev20p11,Agg_SP_Rev25p11,Agg_SP_Rev30p11,Agg_SP_Rev35p11,...
     Agg_SP_Rev40p11,Agg_SP_Rev45p11,Agg_SP_Rev50p11,Agg_Mer_Rev20p11,Agg_Mer_Rev25p11,Agg_Mer_Rev30p11,Agg_Mer_Rev35p11,...
    Agg_Mer_Rev40p11,Agg_Mer_Rev45p11,Agg_Mer_Rev50p11);


 %WRITE and save Excel files - revenues only for CfD (Mer available from former runs
 %Merchant - see results for #R001 and #R002 (high and low price scenario)
 filename1 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p1.xlsx';
 filename2 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p2.xlsx';
 filename3 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p3.xlsx';
 filename4 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p4.xlsx';
 filename5 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p5.xlsx';
 filename6 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p6.xlsx';
 filename7 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p7.xlsx';
 filename8 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p8.xlsx';
 filename9 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p9.xlsx';
 filename10 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p10.xlsx';
 filename11 = 'M:\#R001_GenRev_Vol2\Revenue_Results_Exl\RevenueRuns\CfD_Rev_Fin_p11.xlsx';
 
 
 xlswrite(filename1,CfD_Rev_Fin_p1);
 xlswrite(filename2,CfD_Rev_Fin_p2);
 xlswrite(filename3,CfD_Rev_Fin_p3);
 xlswrite(filename4,CfD_Rev_Fin_p4);
 xlswrite(filename5,CfD_Rev_Fin_p5);
 xlswrite(filename6,CfD_Rev_Fin_p6);
 xlswrite(filename7,CfD_Rev_Fin_p7);
 xlswrite(filename8,CfD_Rev_Fin_p8);
 xlswrite(filename9,CfD_Rev_Fin_p9);
 xlswrite(filename10,CfD_Rev_Fin_p10);
 xlswrite(filename11,CfD_Rev_Fin_p11);

        



