%used to aggregate revenues and make expected revenues
%SIM revenues and EXP revenues

function [CfD_All_p8,SP_All_p8,Mer_All_p8,CfD_Delta_p8,CfD_Rev_21_49_p8,CfD_NonSim_Years_p8,CfD_Rev_Mid_p8,...
    CfD_Rev_Fin_p8, SP_Delta_p8,SP_Rev_21_49_p8,SP_NonSimYears_p8, SP_Rev_Mid_p8,SP_Rev_Fin_p8, Mer_Delta_p8,Mer_Rev_21_49_p8,...
    Mer_NonSimYears_p8,Mer_Rev_Mid_p8,Mer_Rev_Fin_p8,MeanCfD_p8,MeanSP_p8,MeanMer_p8] = AggRevP8(Agg_CfD_Rev20p8,Agg_CfD_Rev25p8,Agg_CfD_Rev30p8,Agg_CfD_Rev35p8,...
    Agg_CfD_Rev40p8,Agg_CfD_Rev45p8,Agg_CfD_Rev50p8,Agg_SP_Rev20p8,Agg_SP_Rev25p8,Agg_SP_Rev30p8,Agg_SP_Rev35p8,...
     Agg_SP_Rev40p8,Agg_SP_Rev45p8,Agg_SP_Rev50p8,Agg_Mer_Rev20p8,Agg_Mer_Rev25p8,Agg_Mer_Rev30p8,Agg_Mer_Rev35p8,...
    Agg_Mer_Rev40p8,Agg_Mer_Rev45p8,Agg_Mer_Rev50p8)

%create one matrix for each revenue type
CfD_All_p8 = [Agg_CfD_Rev20p8;Agg_CfD_Rev25p8;Agg_CfD_Rev30p8;Agg_CfD_Rev35p8;...
    Agg_CfD_Rev40p8;Agg_CfD_Rev45p8;Agg_CfD_Rev50p8]; 

SP_All_p8 = [Agg_SP_Rev20p8;Agg_SP_Rev25p8;Agg_SP_Rev30p8;Agg_SP_Rev35p8;...
     Agg_SP_Rev40p8;Agg_SP_Rev45p8;Agg_SP_Rev50p8]; 
 
Mer_All_p8 = [Agg_Mer_Rev20p8;Agg_Mer_Rev25p8;Agg_Mer_Rev30p8;Agg_Mer_Rev35p8;...
    Agg_Mer_Rev40p8;Agg_Mer_Rev45p8;Agg_Mer_Rev50p8];

%interpolate revenues for CfD

CfD_Delta_p8 = zeros(6,1000);
 YearDiff = 5;
for j=1:6
      CfD_Delta_p8(j,:) = (CfD_All_p8(j+1,:) - CfD_All_p8(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     CfD_Rev_21_49_p8(j,year,:) = CfD_All_p8(j,:) + year*CfD_Delta_p8(j,:); %revenues between simulation years
   end
 end
 CfD_NonSim_Years_p8 = zeros(24,1000); %transformed Rev_CfD matrix
 CfD_NonSim_Years_p8 = squeeze(reshape(permute(CfD_Rev_21_49_p8,[2,1,3]),1,24,1000));
 
 CfD_Rev_Mid_p8 = zeros(length(CfD_NonSim_Years_p8(:,1))+length(CfD_All_p8(:,1)),1000);
 CfD_Rev_Mid_p8 = [CfD_All_p8(1,:); CfD_NonSim_Years_p8(1:4,:)];
 CfD_Rev_Mid_p8 = [CfD_Rev_Mid_p8; CfD_All_p8(2,:); CfD_NonSim_Years_p8(5:8,:)]; % ...
 CfD_Rev_Mid_p8 = [CfD_Rev_Mid_p8; CfD_All_p8(3,:); CfD_NonSim_Years_p8(9:12,:)]; % ...
 CfD_Rev_Mid_p8 = [CfD_Rev_Mid_p8; CfD_All_p8(4,:); CfD_NonSim_Years_p8(13:16,:)]; % ...
 CfD_Rev_Mid_p8 = [CfD_Rev_Mid_p8; CfD_All_p8(5,:); CfD_NonSim_Years_p8(17:20,:)]; %combine 2040 and 2041-2044
 CfD_Rev_Mid_p8 = [CfD_Rev_Mid_p8; CfD_All_p8(6,:); CfD_NonSim_Years_p8(21:24,:)]; %combine 2045 and 2046-2049
 CfD_Rev_Mid_p8 = [CfD_Rev_Mid_p8; CfD_All_p8(7,:)]; %add 2050
 
 CfD_Rev_Fin_p8 = CfD_Rev_Mid_p8';

%interpolate revenues for Sliding Premium

 SP_Delta_p8 = zeros(6,1000);
for j=1:6
      SP_Delta_p8(j,:) = (SP_All_p8(j+1,:) - SP_All_p8(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     SP_Rev_21_49_p8(j,year,:) = SP_All_p8(j,:) + year*SP_Delta_p8(j,:); %revenues between simulation years
   end
 end
 SP_NonSimYears_p8 = zeros(24,1000); %transformed Rev_CfD matrix
 SP_NonSimYears_p8 = squeeze(reshape(permute(SP_Rev_21_49_p8,[2,1,3]),1,24,1000));
 
 SP_Rev_Mid_p8 = zeros(length(SP_NonSimYears_p8(:,1))+length(SP_All_p8(:,1)),1000);
 SP_Rev_Mid_p8 = [SP_All_p8(1,:); SP_NonSimYears_p8(1:4,:)];
 SP_Rev_Mid_p8 = [SP_Rev_Mid_p8; SP_All_p8(2,:); SP_NonSimYears_p8(5:8,:)]; % ...
 SP_Rev_Mid_p8 = [SP_Rev_Mid_p8; SP_All_p8(3,:); SP_NonSimYears_p8(9:12,:)]; % ...
 SP_Rev_Mid_p8 = [SP_Rev_Mid_p8; SP_All_p8(4,:); SP_NonSimYears_p8(13:16,:)]; % ...
 SP_Rev_Mid_p8 = [SP_Rev_Mid_p8; SP_All_p8(5,:); SP_NonSimYears_p8(17:20,:)]; %combine 2040 and 2041-2044
 SP_Rev_Mid_p8 = [SP_Rev_Mid_p8; SP_All_p8(6,:); SP_NonSimYears_p8(21:24,:)]; %combine 2045 and 2046-2049
 SP_Rev_Mid_p8 = [SP_Rev_Mid_p8; SP_All_p8(7,:)]; %add 2050
 
 SP_Rev_Fin_p8 = SP_Rev_Mid_p8';
 
  %interpolate revenues for Merchant
 
 Mer_Delta_p8 = zeros(6,1000);
for j=1:6
      Mer_Delta_p8(j,:) = (Mer_All_p8(j+1,:) - Mer_All_p8(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     Mer_Rev_21_49_p8(j,year,:) = Mer_All_p8(j,:) + year*Mer_Delta_p8(j,:); %revenues between simulation years
   end
 end
 Mer_NonSimYears_p8 = zeros(24,1000); %transformed Rev_CfD matrix
 Mer_NonSimYears_p8 = squeeze(reshape(permute(Mer_Rev_21_49_p8,[2,1,3]),1,24,1000));
 
 Mer_Rev_Mid_p8 = zeros(length(Mer_NonSimYears_p8(:,1))+length(Mer_All_p8(:,1)),1000);
 Mer_Rev_Mid_p8 = [Mer_All_p8(1,:); Mer_NonSimYears_p8(1:4,:)];
 Mer_Rev_Mid_p8 = [Mer_Rev_Mid_p8; Mer_All_p8(2,:); Mer_NonSimYears_p8(5:8,:)]; % ...
 Mer_Rev_Mid_p8 = [Mer_Rev_Mid_p8; Mer_All_p8(3,:); Mer_NonSimYears_p8(9:12,:)]; % ...
 Mer_Rev_Mid_p8 = [Mer_Rev_Mid_p8; Mer_All_p8(4,:); Mer_NonSimYears_p8(13:16,:)]; % ...
 Mer_Rev_Mid_p8 = [Mer_Rev_Mid_p8; Mer_All_p8(5,:); Mer_NonSimYears_p8(17:20,:)]; %combine 2040 and 2041-2044
 Mer_Rev_Mid_p8 = [Mer_Rev_Mid_p8; Mer_All_p8(6,:); Mer_NonSimYears_p8(21:24,:)]; %combine 2045 and 2046-2049
 Mer_Rev_Mid_p8 = [Mer_Rev_Mid_p8; Mer_All_p8(7,:)]; %add 2050
 
 Mer_Rev_Fin_p8 = Mer_Rev_Mid_p8';
 
 %SUMMARY CALCS
 
 %Make mean of all scenarios - to have an idea of the average revenue curve
 MeanCfD_p8 = mean(CfD_Rev_Fin_p8);
 MeanSP_p8 = mean(SP_Rev_Fin_p8);
 MeanMer_p8 = mean(Mer_Rev_Fin_p8);
 
end


 