clear all;
load  CapFac_DEAll_2019_sorted;
load  HornsRevB_Prc_sort;
addpath ('C:\Mak\000000  MATLAB MAIN FOLDER 000000\MATLAB_outputs\#R001');
load 2020_1000sim_R001; 
 
p = polyfit(CapFac_DEAll_2019_sorted,HornsRevB_Prc_sort,5);
y1 = polyval(p,CapFac_DEAll_2019_sorted);

Fig1 = figure('Name','HornsRevB vs All DE for 2019');
scatter(CapFac_DEAll_2019_sorted, HornsRevB_Prc_sort,16,'r');
hold on
plot (CapFac_DEAll_2019_sorted,y1,'--b');
plot (CapFac_DEAll_2019_sorted,y1_adj,'--g');
hold off
 
legend({'scatter HornsRevB & All DE','poly & All DE '},'Location','southeast','Orientation','vertical');

 title('HornsRevB vs All DE for 2019')
 axis([0 0.8 0  1]);
 xlabel('All DE','FontSize',12)      
 ylabel('Horns Rev B','FontSize',12)
 
%  fname = 'C:\Mak\000000  MATLAB MAIN FOLDER 000000\MATLAB_outputs\Poly Fitting';
%  saveas(Fig1, fullfile(fname, 'HornsRevB and AllDE for 2019 - fit function.png'));
%  
%  save(fullfile(fname,'PolyFit.mat'),'p');
%  save(fullfile(fname,'FittedFunction.mat'),'y1');