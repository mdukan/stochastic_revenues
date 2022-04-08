%used to aggregate revenues and make expected revenues
%SIM revenues and EXP revenues

clear all;
load CF_Average_AllSimYears;
load fundamental_price_level;
load Hours_Year_EXPRev;
addpath ('M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\y2020to2050');
load Rev20_50_all;

%create one matrix for each revenue type
CfD_All = [Agg_CfD_Rev20;Agg_CfD_Rev25;Agg_CfD_Rev30;Agg_CfD_Rev35;...
    Agg_CfD_Rev40;Agg_CfD_Rev45;Agg_CfD_Rev50]; 

SP_All = [Agg_SP_Rev20;Agg_SP_Rev25;Agg_SP_Rev30;Agg_SP_Rev35;...
     Agg_SP_Rev40;Agg_SP_Rev45;Agg_SP_Rev50]; 
 
Mer_All = [Agg_Mer_Rev20;Agg_Mer_Rev25;Agg_Mer_Rev30;Agg_Mer_Rev35;...
    Agg_Mer_Rev40;Agg_Mer_Rev45;Agg_Mer_Rev50];

%interpolate revenues for CfD

CfD_Delta = zeros(6,1000);
 YearDiff = 5;
for j=1:6
      CfD_Delta(j,:) = (CfD_All(j+1,:) - CfD_All(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     CfD_Rev_21_49(j,year,:) = CfD_All(j,:) + year*CfD_Delta(j,:); %revenues between simulation years
   end
 end
 CfD_NonSim_Years = zeros(24,1000); %transformed Rev_CfD matrix
 CfD_NonSim_Years = squeeze(reshape(permute(CfD_Rev_21_49,[2,1,3]),1,24,1000));
 
 CfD_Rev_Mid = zeros(length(CfD_NonSim_Years(:,1))+length(CfD_All(:,1)),1000);
 CfD_Rev_Mid = [CfD_All(1,:); CfD_NonSim_Years(1:4,:)];
 CfD_Rev_Mid = [CfD_Rev_Mid; CfD_All(2,:); CfD_NonSim_Years(5:8,:)]; % ...
 CfD_Rev_Mid = [CfD_Rev_Mid; CfD_All(3,:); CfD_NonSim_Years(9:12,:)]; % ...
 CfD_Rev_Mid = [CfD_Rev_Mid; CfD_All(4,:); CfD_NonSim_Years(13:16,:)]; % ...
 CfD_Rev_Mid = [CfD_Rev_Mid; CfD_All(5,:); CfD_NonSim_Years(17:20,:)]; %combine 2040 and 2041-2044
 CfD_Rev_Mid = [CfD_Rev_Mid; CfD_All(6,:); CfD_NonSim_Years(21:24,:)]; %combine 2045 and 2046-2049
 CfD_Rev_Mid = [CfD_Rev_Mid; CfD_All(7,:)]; %add 2050
 
 CfD_Rev_Fin = CfD_Rev_Mid';

%interpolate revenues for Sliding Premium

 SP_Delta = zeros(6,1000);
for j=1:6
      SP_Delta(j,:) = (SP_All(j+1,:) - SP_All(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     SP_Rev_21_49(j,year,:) = SP_All(j,:) + year*SP_Delta(j,:); %revenues between simulation years
   end
 end
 SP_NonSimYears = zeros(24,1000); %transformed Rev_CfD matrix
 SP_NonSimYears = squeeze(reshape(permute(SP_Rev_21_49,[2,1,3]),1,24,1000));
 
 SP_Rev_Mid = zeros(length(SP_NonSimYears(:,1))+length(SP_All(:,1)),1000);
 SP_Rev_Mid = [SP_All(1,:); SP_NonSimYears(1:4,:)];
 SP_Rev_Mid = [SP_Rev_Mid; SP_All(2,:); SP_NonSimYears(5:8,:)]; % ...
 SP_Rev_Mid = [SP_Rev_Mid; SP_All(3,:); SP_NonSimYears(9:12,:)]; % ...
 SP_Rev_Mid = [SP_Rev_Mid; SP_All(4,:); SP_NonSimYears(13:16,:)]; % ...
 SP_Rev_Mid = [SP_Rev_Mid; SP_All(5,:); SP_NonSimYears(17:20,:)]; %combine 2040 and 2041-2044
 SP_Rev_Mid = [SP_Rev_Mid; SP_All(6,:); SP_NonSimYears(21:24,:)]; %combine 2045 and 2046-2049
 SP_Rev_Mid = [SP_Rev_Mid; SP_All(7,:)]; %add 2050
 
 SP_Rev_Fin = SP_Rev_Mid';
 
  %interpolate revenues for Merchant
 
 Mer_Delta = zeros(6,1000);
for j=1:6
      Mer_Delta(j,:) = (Mer_All(j+1,:) - Mer_All(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     Mer_Rev_21_49(j,year,:) = Mer_All(j,:) + year*Mer_Delta(j,:); %revenues between simulation years
   end
 end
 Mer_NonSimYears = zeros(24,1000); %transformed Rev_CfD matrix
 Mer_NonSimYears = squeeze(reshape(permute(Mer_Rev_21_49,[2,1,3]),1,24,1000));
 
 Mer_Rev_Mid = zeros(length(Mer_NonSimYears(:,1))+length(Mer_All(:,1)),1000);
 Mer_Rev_Mid = [Mer_All(1,:); Mer_NonSimYears(1:4,:)];
 Mer_Rev_Mid = [Mer_Rev_Mid; Mer_All(2,:); Mer_NonSimYears(5:8,:)]; % ...
 Mer_Rev_Mid = [Mer_Rev_Mid; Mer_All(3,:); Mer_NonSimYears(9:12,:)]; % ...
 Mer_Rev_Mid = [Mer_Rev_Mid; Mer_All(4,:); Mer_NonSimYears(13:16,:)]; % ...
 Mer_Rev_Mid = [Mer_Rev_Mid; Mer_All(5,:); Mer_NonSimYears(17:20,:)]; %combine 2040 and 2041-2044
 Mer_Rev_Mid = [Mer_Rev_Mid; Mer_All(6,:); Mer_NonSimYears(21:24,:)]; %combine 2045 and 2046-2049
 Mer_Rev_Mid = [Mer_Rev_Mid; Mer_All(7,:)]; %add 2050
 
 Mer_Rev_Fin = Mer_Rev_Mid';
 
 %SUMMARY CALCS
 
 %Make mean of all scenarios - to have an idea of the average revenue curve
 MeanCfD = mean(CfD_Rev_Fin);
 MeanSP = mean(SP_Rev_Fin);
 MeanMer = mean(Mer_Rev_Fin);
 
 %Expected revenues
 [EXP_CF,EXP_CF_All,EXP_CF_All_y,Prod_Year_EXP,Mer_EXP_rev,CfD_EXP_rev,SP_EXP_rev] = ExpectedCF_n(meanCF20,meanCF25,meanCF30,...
    meanCF35,meanCF40,meanCF45,meanCF50,Hours_Year_EXPRev,fundamental_price_level);

 %SUMMARY FIGURES
 
 %Mean revenues for all years and all scenarios
 Years = 31;
 Fig1 = figure('Name','Revenue curves 2020 to 2050');
 p1 = plot(1:Years,MeanCfD,'-k');
 hold on
 p2 = plot(1:Years,MeanSP,'-m');
 p3 = plot(1:Years,MeanMer,'-y');
 hold off
 
 p1.LineWidth = 2;
 p2.LineWidth = 2;
 p3.LineWidth = 2;
 
 legend({'CfD','Sliding Premium', 'Merchant'},'Location','southeast','Orientation','vertical');
 title('Mean revenues')
 axis([0 Years 100000  500000]);
 xlabel('Years - 2020 to 2050','FontSize',12)      
 ylabel('Revenues per MW (EUR)','FontSize',12)
 
 %All scenarios CfD
 Years = 31;
 Fig2 = figure('Name','Revenues for all scenarios - CfD');
 hold on
 plot(1:Years,CfD_Rev_Fin,'-k');
 hold off
 
 title('All CfD')
 axis([0 Years 0  500000]);
 xlabel('Years - 2020 to 2050','FontSize',12)      
 ylabel('Revenues per MW (EUR)','FontSize',12)
 
 %All scenarios SP
 Years = 31;
 Fig3 = figure('Name','Revenues for all scenarios - SP');
 hold on
 plot(1:Years,SP_Rev_Fin,'-m');
 hold off

 title('All SP')
 axis([0 Years 0  500000]);
 xlabel('Years - 2020 to 2050','FontSize',12)      
 ylabel('Revenues per MW (EUR)','FontSize',12)

 %All scenarios SP
 Years = 31;
 Fig4 = figure('Name','Revenues for all scenarios - SP');
 hold on
 plot(1:Years,Mer_Rev_Fin,'-y');
 hold off

 title('All Mer')
 axis([0 Years 0  500000]);
 xlabel('Years - 2020 to 2050','FontSize',12)      
 ylabel('Revenues per MW (EUR)','FontSize',12)

 %SAVE figures
 fname = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\SIM';
 saveas(Fig1, fullfile(fname, 'Revenue curves 2020 to 2050.png'));
 saveas(Fig2, fullfile(fname, 'All CfD.png'));
 saveas(Fig3, fullfile(fname, 'All SP.png'));
 saveas(Fig4, fullfile(fname, 'All Mer.png'));

 %SAVE new variables 
 save(fullfile(fname,'Mer_Rev_Fin.mat'),'Mer_Rev_Fin');
 save(fullfile(fname,'SP_Rev_Fin.mat'),'SP_Rev_Fin');
 save(fullfile(fname,'CfD_Rev_Fin.mat'),'CfD_Rev_Fin');
 
 %WRITE and save Excel files - aggregated revenues
 filename1 = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\SIM\CfD4Excel.xlsx';
 filename2 = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\SIM\SP4Excel.xlsx';
 filename3 = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\SIM\Mer4Excel.xlsx';
 xlswrite(filename1,CfD_Rev_Fin);
 xlswrite(filename2,SP_Rev_Fin);
 xlswrite(filename3,Mer_Rev_Fin);

 %WRITE and save Excel files - expected revenues
 filename1 = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\EXP\CfD_EXP_rev.xlsx';
 filename2 = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\EXP\SP_EXP_rev.xlsx';
 filename3 = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\EXP\Mer_EXP_rev.xlsx';
 filename4 = 'M:\Mak Folder\PAPERS\Paper C\#### MATLAB MAIN ####\For Gen Revenues\EXP\Prod_Year_EXP.xlsx';
 xlswrite(filename1,CfD_EXP_rev);
 xlswrite(filename2,SP_EXP_rev);
 xlswrite(filename3,Mer_EXP_rev);
 xlswrite(filename4,Prod_Year_EXP);
        

 