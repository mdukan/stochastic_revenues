clear all;
load  CapFac_DEAll_2017to2019; %polyfitting
load  HornsRevB_2017to2019; %polyfitting
load  HornsRevB_2017to2019_LY; %just for making mean and comparing (leap year issue)
addpath ('C:\Mak\000000  MATLAB MAIN FOLDER 000000\MATLAB_outputs\#R001');
load 2020_1000sim_R001_LY; %contains SimWind with 8784 h, copied first day to last

%sorting of the data into load duration curves
CapFac_DEAll_2017to2019_ld = sort(CapFac_DEAll_2017to2019,'descend');
HornsRevB_2017to2019_ld = sort(HornsRevB_2017to2019,'descend');

%fit polynomial function and make fitted curve (polyval)
%this is just for 2019 data (non leap year!!)
p2017to2019HRb = polyfit(CapFac_DEAll_2017to2019_ld,HornsRevB_2017to2019_ld,5);
y1 = polyval(p2017to2019HRb,CapFac_DEAll_2017to2019_ld);

%CAPACITY FACTOR SimWind
CapFacSimWind = SimWind / SimWindCapacity;

%OUTPUT ANALYSIS - min and max for SimWind
MAX_CapFac_SimWind = max(CapFacSimWind);
MIN_CapFac_SimWind = min(CapFacSimWind);

%upscale SimWind - when using 5 degrees
SimWind_CapFac_UP = zeros(SimHours,numberSim);
for y =1:numberSim
    for x=1:SimHours
       SimWind_CapFac_UP(x,y) = p2017to2019HRb(1)*CapFacSimWind(x,y)^5+p2017to2019HRb(2)*CapFacSimWind(x,y)^4+p2017to2019HRb(3)*CapFacSimWind(x,y)^3+...
       p2017to2019HRb(4)*CapFacSimWind(x,y)^2+p2017to2019HRb(5)*CapFacSimWind(x,y)+p2017to2019HRb(6);
    end
end

%upscaled capacity factor analysis
MAX_CapFac_UP = max(SimWind_CapFac_UP);
MIN_CapFac_UP = min(SimWind_CapFac_UP);
AV_CapFac_UP = mean(SimWind_CapFac_UP);

%CALL capacity factor data correction function
[CountIF_neg,Sum_NegTotal,CountIF_exc1, Sum_exc1Total,SimWind_CapFac_UP_Fin,SimWind_CapFac_UP_Fin_ld,FittedCapFac_mean_fin,...
    HornsRevB_Reshaped_ld,Mean_HornsRevB_2017to2019_ld,DELTA_FIN,Mean_DELTA_FIN,Sum_DELTA_FIN...
    ] = CapFacCorrectionLY(SimWind_CapFac_UP,HornsRevB_2017to2019_LY,SimHours);

%Calculate correlation between fitted curve and selected plant
CORR = corr(FittedCapFac_mean_fin,Mean_HornsRevB_2017to2019_ld);

%CALL revenue calculation function
[Agg_SP_Rev20,Rev_SP20,Agg_Mer_Rev20,Rev_Mer20,Agg_CfD_Rev20,Rev_CfD20] = RevCalc_new(SimWind_CapFac_UP_Fin, SimPrices, Price_floor, SimHours, numberSim);

%MAKE FIGURES
%Scatter plot - DE ALL vs HornsRevB
Fig1 = figure('Name','HornsRevB 2017 to 2019 vs All DE 2017 to 2019');
scatter(CapFac_DEAll_2017to2019_ld,HornsRevB_2017to2019_ld,16,'r');
hold on
plot (CapFac_DEAll_2017to2019_ld,y1,'--b');
hold off
 
legend({'scatter HornsRevB & All DE','poly & All DE '},'Location','southeast','Orientation','vertical');
title('HornsRevB vs All DE for 2017 to 2019')
axis([0 1 0 1]);
xlabel('All DE','FontSize',12)      
ylabel('Horns Rev B','FontSize',12)

%Histogram - capacity factors of the fitted y1 curve
Fig2 = figure('Name','Histogram');
histogram(y1);

title('Histogram plotted curve (y1)')
axis([-0.2 1.2 0  5000]);
xlabel('Capacity factors','FontSize',12)      
ylabel('Number of occurances','FontSize',12)

%Histogram - selected plant
Fig3 = figure('Name','Histogram Selected Plant');
histogram(HornsRevB_2017to2019_ld);

title('Histogram Selected Plant')
axis([-0.2 1.2 0  5000]);
xlabel('Capacity factors','FontSize',12)      
ylabel('Number of occurances','FontSize',12)

%Fitted capacity factors curve
SimHoursPlot = SimHours;
Fig4 = figure('Name','Fitted Capacity Factors vs HornsRevB average 2017 to 2019');

plot(1:SimHoursPlot,FittedCapFac_mean_fin,'-b')
hold on
plot(1:SimHoursPlot,Mean_HornsRevB_2017to2019_ld,'-r')
hold off

legend({'Fitted capacity factors','HornsRevB Average 2017 to 2019'},'Location','southeast','Orientation','vertical');
title('Fitted capacity factors vs HornsRevB Load Duration Curves')
axis([0 SimHoursPlot 0  1]);
xlabel('hours','FontSize',12)      
ylabel('Capacity factor [%]','FontSize',12)

%Histogram 
Fig5 = figure('Name','Fitted Load Duration Curve Capacity Factors');
histogram(AV_CapFac_UP);

title('Fitted Load Duration Curve Cap Factors')
axis([0.2 0.8 0 250]);
xlabel('Capacity factors','FontSize',12)      
ylabel('Number of occurances','FontSize',12)

%SAVE figures
fname = 'C:\Mak\000001 MATLAB MAIN FOLDER 000001\MATLAB_outputs\Polyfitting\HornsRevB_2017to2019';
saveas(Fig1, fullfile(fname, 'HornsRevB and AllDE for 2017 to 2019 - fit function.png'));
saveas(Fig2, fullfile(fname, 'Histogram of plotted curve.png'));
saveas(Fig3, fullfile(fname, 'Histogram of selected plant.png'));
saveas(Fig4, fullfile(fname, 'Fitted Capacity Factors vs HornsRevB.png'));
saveas(Fig5, fullfile(fname, 'Fitted Load Duration Curve Capacity Factors.png'));

%SAVE new variables - polyfitting
save(fullfile(fname,'p2017to2019HRb.mat'),'p2017to2019HRb');
save(fullfile(fname,'y1.mat'),'y1');
save(fullfile(fname,'SimWind_CapFac_UP.mat'),'SimWind_CapFac_UP');
save(fullfile(fname,'MAX_CapFac_SimWind.mat'),'MAX_CapFac_SimWind');
save(fullfile(fname,'MIN_CapFac_SimWind.mat'),'MIN_CapFac_SimWind');
save(fullfile(fname,'MAX_CapFac_UP.mat'),'MAX_CapFac_UP');
save(fullfile(fname,'MIN_CapFac_UP.mat'),'MIN_CapFac_UP');
save(fullfile(fname,'AV_CapFac_UP.mat'),'AV_CapFac_UP');
save(fullfile(fname,'FittedCapFac_mean_fin.mat'),'FittedCapFac_mean_fin');
save(fullfile(fname,'CORR.mat'),'CORR');
save(fullfile(fname,'SimWind_CapFac_UP_Fin.mat'),'SimWind_CapFac_UP_Fin');
save(fullfile(fname,'CountIF_neg.mat'),'CountIF_neg');
save(fullfile(fname,'Sum_NegTotal.mat'),'Sum_NegTotal');
save(fullfile(fname,'CountIF_exc1.mat'),'CountIF_exc1');
save(fullfile(fname,'Sum_exc1Total.mat'),'Sum_exc1Total');
save(fullfile(fname,'Mean_DELTA_FIN,mat'),'Mean_DELTA_FIN');
save(fullfile(fname,'Sum_DELTA_FIN.mat'),'Sum_DELTA_FIN');
save(fullfile(fname,'DELTA_FIN.mat'),'DELTA_FIN');

%SAVE new variables - revenues
fname2 = 'C:\Mak\000001 MATLAB MAIN FOLDER 000001\MATLAB_outputs\#R002_Rev';
save(fullfile(fname2,'Agg_SP_Rev20.mat'),'Agg_SP_Rev20');
save(fullfile(fname2,'Agg_Mer_Rev20.mat'),'Agg_Mer_Rev20');
save(fullfile(fname2,'Agg_CfD_Rev20.mat'),'Agg_CfD_Rev20');
save(fullfile(fname2,'Rev_SP20.mat'),'Rev_SP20');
save(fullfile(fname2,'Rev_Mer20.mat'),'Rev_Mer20');
save(fullfile(fname2,'Rev_CfD20.mat'),'Rev_CfD20');



