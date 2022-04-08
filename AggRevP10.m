%used to aggregate revenues and make expected revenues
%SIM revenues and EXP revenues

function [CfD_All_p10,SP_All_p10,Mer_All_p10,CfD_Delta_p10,CfD_Rev_21_49_p10,CfD_NonSim_Years_p10,CfD_Rev_Mid_p10,...
    CfD_Rev_Fin_p10, SP_Delta_p10,SP_Rev_21_49_p10,SP_NonSimYears_p10, SP_Rev_Mid_p10,SP_Rev_Fin_p10, Mer_Delta_p10,Mer_Rev_21_49_p10,...
    Mer_NonSimYears_p10,Mer_Rev_Mid_p10,Mer_Rev_Fin_p10,MeanCfD_p10,MeanSP_p10,MeanMer_p10] = AggRevP10(Agg_CfD_Rev20p10,Agg_CfD_Rev25p10,Agg_CfD_Rev30p10,Agg_CfD_Rev35p10,...
    Agg_CfD_Rev40p10,Agg_CfD_Rev45p10,Agg_CfD_Rev50p10,Agg_SP_Rev20p10,Agg_SP_Rev25p10,Agg_SP_Rev30p10,Agg_SP_Rev35p10,...
     Agg_SP_Rev40p10,Agg_SP_Rev45p10,Agg_SP_Rev50p10,Agg_Mer_Rev20p10,Agg_Mer_Rev25p10,Agg_Mer_Rev30p10,Agg_Mer_Rev35p10,...
    Agg_Mer_Rev40p10,Agg_Mer_Rev45p10,Agg_Mer_Rev50p10)

%create one matrix for each revenue type
CfD_All_p10 = [Agg_CfD_Rev20p10;Agg_CfD_Rev25p10;Agg_CfD_Rev30p10;Agg_CfD_Rev35p10;...
    Agg_CfD_Rev40p10;Agg_CfD_Rev45p10;Agg_CfD_Rev50p10]; 

SP_All_p10 = [Agg_SP_Rev20p10;Agg_SP_Rev25p10;Agg_SP_Rev30p10;Agg_SP_Rev35p10;...
     Agg_SP_Rev40p10;Agg_SP_Rev45p10;Agg_SP_Rev50p10]; 
 
Mer_All_p10 = [Agg_Mer_Rev20p10;Agg_Mer_Rev25p10;Agg_Mer_Rev30p10;Agg_Mer_Rev35p10;...
    Agg_Mer_Rev40p10;Agg_Mer_Rev45p10;Agg_Mer_Rev50p10];

%interpolate revenues for CfD

CfD_Delta_p10 = zeros(6,1000);
 YearDiff = 5;
for j=1:6
      CfD_Delta_p10(j,:) = (CfD_All_p10(j+1,:) - CfD_All_p10(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     CfD_Rev_21_49_p10(j,year,:) = CfD_All_p10(j,:) + year*CfD_Delta_p10(j,:); %revenues between simulation years
   end
 end
 CfD_NonSim_Years_p10 = zeros(24,1000); %transformed Rev_CfD matrix
 CfD_NonSim_Years_p10 = squeeze(reshape(permute(CfD_Rev_21_49_p10,[2,1,3]),1,24,1000));
 
 CfD_Rev_Mid_p10 = zeros(length(CfD_NonSim_Years_p10(:,1))+length(CfD_All_p10(:,1)),1000);
 CfD_Rev_Mid_p10 = [CfD_All_p10(1,:); CfD_NonSim_Years_p10(1:4,:)];
 CfD_Rev_Mid_p10 = [CfD_Rev_Mid_p10; CfD_All_p10(2,:); CfD_NonSim_Years_p10(5:8,:)]; % ...
 CfD_Rev_Mid_p10 = [CfD_Rev_Mid_p10; CfD_All_p10(3,:); CfD_NonSim_Years_p10(9:12,:)]; % ...
 CfD_Rev_Mid_p10 = [CfD_Rev_Mid_p10; CfD_All_p10(4,:); CfD_NonSim_Years_p10(13:16,:)]; % ...
 CfD_Rev_Mid_p10 = [CfD_Rev_Mid_p10; CfD_All_p10(5,:); CfD_NonSim_Years_p10(17:20,:)]; %combine 2040 and 2041-2044
 CfD_Rev_Mid_p10 = [CfD_Rev_Mid_p10; CfD_All_p10(6,:); CfD_NonSim_Years_p10(21:24,:)]; %combine 2045 and 2046-2049
 CfD_Rev_Mid_p10 = [CfD_Rev_Mid_p10; CfD_All_p10(7,:)]; %add 2050
 
 CfD_Rev_Fin_p10 = CfD_Rev_Mid_p10';

%interpolate revenues for Sliding Premium

 SP_Delta_p10 = zeros(6,1000);
for j=1:6
      SP_Delta_p10(j,:) = (SP_All_p10(j+1,:) - SP_All_p10(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     SP_Rev_21_49_p10(j,year,:) = SP_All_p10(j,:) + year*SP_Delta_p10(j,:); %revenues between simulation years
   end
 end
 SP_NonSimYears_p10 = zeros(24,1000); %transformed Rev_CfD matrix
 SP_NonSimYears_p10 = squeeze(reshape(permute(SP_Rev_21_49_p10,[2,1,3]),1,24,1000));
 
 SP_Rev_Mid_p10 = zeros(length(SP_NonSimYears_p10(:,1))+length(SP_All_p10(:,1)),1000);
 SP_Rev_Mid_p10 = [SP_All_p10(1,:); SP_NonSimYears_p10(1:4,:)];
 SP_Rev_Mid_p10 = [SP_Rev_Mid_p10; SP_All_p10(2,:); SP_NonSimYears_p10(5:8,:)]; % ...
 SP_Rev_Mid_p10 = [SP_Rev_Mid_p10; SP_All_p10(3,:); SP_NonSimYears_p10(9:12,:)]; % ...
 SP_Rev_Mid_p10 = [SP_Rev_Mid_p10; SP_All_p10(4,:); SP_NonSimYears_p10(13:16,:)]; % ...
 SP_Rev_Mid_p10 = [SP_Rev_Mid_p10; SP_All_p10(5,:); SP_NonSimYears_p10(17:20,:)]; %combine 2040 and 2041-2044
 SP_Rev_Mid_p10 = [SP_Rev_Mid_p10; SP_All_p10(6,:); SP_NonSimYears_p10(21:24,:)]; %combine 2045 and 2046-2049
 SP_Rev_Mid_p10 = [SP_Rev_Mid_p10; SP_All_p10(7,:)]; %add 2050
 
 SP_Rev_Fin_p10 = SP_Rev_Mid_p10';
 
  %interpolate revenues for Merchant
 
 Mer_Delta_p10 = zeros(6,1000);
for j=1:6
      Mer_Delta_p10(j,:) = (Mer_All_p10(j+1,:) - Mer_All_p10(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     Mer_Rev_21_49_p10(j,year,:) = Mer_All_p10(j,:) + year*Mer_Delta_p10(j,:); %revenues between simulation years
   end
 end
 Mer_NonSimYears_p10 = zeros(24,1000); %transformed Rev_CfD matrix
 Mer_NonSimYears_p10 = squeeze(reshape(permute(Mer_Rev_21_49_p10,[2,1,3]),1,24,1000));
 
 Mer_Rev_Mid_p10 = zeros(length(Mer_NonSimYears_p10(:,1))+length(Mer_All_p10(:,1)),1000);
 Mer_Rev_Mid_p10 = [Mer_All_p10(1,:); Mer_NonSimYears_p10(1:4,:)];
 Mer_Rev_Mid_p10 = [Mer_Rev_Mid_p10; Mer_All_p10(2,:); Mer_NonSimYears_p10(5:8,:)]; % ...
 Mer_Rev_Mid_p10 = [Mer_Rev_Mid_p10; Mer_All_p10(3,:); Mer_NonSimYears_p10(9:12,:)]; % ...
 Mer_Rev_Mid_p10 = [Mer_Rev_Mid_p10; Mer_All_p10(4,:); Mer_NonSimYears_p10(13:16,:)]; % ...
 Mer_Rev_Mid_p10 = [Mer_Rev_Mid_p10; Mer_All_p10(5,:); Mer_NonSimYears_p10(17:20,:)]; %combine 2040 and 2041-2044
 Mer_Rev_Mid_p10 = [Mer_Rev_Mid_p10; Mer_All_p10(6,:); Mer_NonSimYears_p10(21:24,:)]; %combine 2045 and 2046-2049
 Mer_Rev_Mid_p10 = [Mer_Rev_Mid_p10; Mer_All_p10(7,:)]; %add 2050
 
 Mer_Rev_Fin_p10 = Mer_Rev_Mid_p10';
 
 %SUMMARY CALCS
 
 %Make mean of all scenarios - to have an idea of the average revenue curve
 MeanCfD_p10 = mean(CfD_Rev_Fin_p10);
 MeanSP_p10 = mean(SP_Rev_Fin_p10);
 MeanMer_p10 = mean(Mer_Rev_Fin_p10);
 
end


 