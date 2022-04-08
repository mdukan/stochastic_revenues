 %plotting mean load duration  curves in one graph
 %need to load mean cap factors for all scenarios for the three cases
 clear all
 addpath ('C:\Mak\000000  MATLAB MAIN FOLDER 000000\MATLAB_price_model\PreisprozesseRES');
 load CapFac_LoadDuration; 
 load SimHours;
 load CapFac_HornsRevB_2019_sorted;
 SimHoursPlot = SimHours;

 Fig1 = figure('Name','Duration curve for average hour - all');
 plot(1:SimHoursPlot,CapFac_mean_fin_WindIndex,'-r')
 hold on
 plot(1:SimHoursPlot,CapFac_mean_fin_OFFDE2019,'-g')
 plot(1:SimHoursPlot,CapFac_mean_fin_Borkum,'-m')
 plot(1:SimHoursPlot,CapFac_HornsRevB_2019_sorted,'-b')
 hold off
 
 legend({'DE mean 2015 to 2019','DE 2019','Borkum 2019','HornsRevB'},'Location','northeast','Orientation','vertical')

 title('Load duration curve for 2020 - wind indexes vs HornsRevB')
 axis([0 SimHoursPlot 0  1]);
 xlabel('hours','FontSize',12)      
 ylabel('Capacity factor [%]','FontSize',12)
 
%  fname = 'C:\Mak\000000  MATLAB MAIN FOLDER 000000\MATLAB_outputs\#R001';
%  saveas(Fig1, fullfile(fname, 'Duration curve - mean capacity factors - all scenarios.png'));
 
