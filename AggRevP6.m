%used to aggregate revenues and make expected revenues
%SIM revenues and EXP revenues

function [CfD_All_p6,SP_All_p6,Mer_All_p6,CfD_Delta_p6,CfD_Rev_21_49_p6,CfD_NonSim_Years_p6,CfD_Rev_Mid_p6,...
    CfD_Rev_Fin_p6, SP_Delta_p6,SP_Rev_21_49_p6,SP_NonSimYears_p6, SP_Rev_Mid_p6,SP_Rev_Fin_p6, Mer_Delta_p6,Mer_Rev_21_49_p6,...
    Mer_NonSimYears_p6,Mer_Rev_Mid_p6,Mer_Rev_Fin_p6,MeanCfD_p6,MeanSP_p6,MeanMer_p6] = AggRevP6(Agg_CfD_Rev20p6,Agg_CfD_Rev25p6,Agg_CfD_Rev30p6,Agg_CfD_Rev35p6,...
    Agg_CfD_Rev40p6,Agg_CfD_Rev45p6,Agg_CfD_Rev50p6,Agg_SP_Rev20p6,Agg_SP_Rev25p6,Agg_SP_Rev30p6,Agg_SP_Rev35p6,...
     Agg_SP_Rev40p6,Agg_SP_Rev45p6,Agg_SP_Rev50p6,Agg_Mer_Rev20p6,Agg_Mer_Rev25p6,Agg_Mer_Rev30p6,Agg_Mer_Rev35p6,...
    Agg_Mer_Rev40p6,Agg_Mer_Rev45p6,Agg_Mer_Rev50p6)

%create one matrix for each revenue type
CfD_All_p6 = [Agg_CfD_Rev20p6;Agg_CfD_Rev25p6;Agg_CfD_Rev30p6;Agg_CfD_Rev35p6;...
    Agg_CfD_Rev40p6;Agg_CfD_Rev45p6;Agg_CfD_Rev50p6]; 

SP_All_p6 = [Agg_SP_Rev20p6;Agg_SP_Rev25p6;Agg_SP_Rev30p6;Agg_SP_Rev35p6;...
     Agg_SP_Rev40p6;Agg_SP_Rev45p6;Agg_SP_Rev50p6]; 
 
Mer_All_p6 = [Agg_Mer_Rev20p6;Agg_Mer_Rev25p6;Agg_Mer_Rev30p6;Agg_Mer_Rev35p6;...
    Agg_Mer_Rev40p6;Agg_Mer_Rev45p6;Agg_Mer_Rev50p6];

%interpolate revenues for CfD

CfD_Delta_p6 = zeros(6,1000);
 YearDiff = 5;
for j=1:6
      CfD_Delta_p6(j,:) = (CfD_All_p6(j+1,:) - CfD_All_p6(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     CfD_Rev_21_49_p6(j,year,:) = CfD_All_p6(j,:) + year*CfD_Delta_p6(j,:); %revenues between simulation years
   end
 end
 CfD_NonSim_Years_p6 = zeros(24,1000); %transformed Rev_CfD matrix
 CfD_NonSim_Years_p6 = squeeze(reshape(permute(CfD_Rev_21_49_p6,[2,1,3]),1,24,1000));
 
 CfD_Rev_Mid_p6 = zeros(length(CfD_NonSim_Years_p6(:,1))+length(CfD_All_p6(:,1)),1000);
 CfD_Rev_Mid_p6 = [CfD_All_p6(1,:); CfD_NonSim_Years_p6(1:4,:)];
 CfD_Rev_Mid_p6 = [CfD_Rev_Mid_p6; CfD_All_p6(2,:); CfD_NonSim_Years_p6(5:8,:)]; % ...
 CfD_Rev_Mid_p6 = [CfD_Rev_Mid_p6; CfD_All_p6(3,:); CfD_NonSim_Years_p6(9:12,:)]; % ...
 CfD_Rev_Mid_p6 = [CfD_Rev_Mid_p6; CfD_All_p6(4,:); CfD_NonSim_Years_p6(13:16,:)]; % ...
 CfD_Rev_Mid_p6 = [CfD_Rev_Mid_p6; CfD_All_p6(5,:); CfD_NonSim_Years_p6(17:20,:)]; %combine 2040 and 2041-2044
 CfD_Rev_Mid_p6 = [CfD_Rev_Mid_p6; CfD_All_p6(6,:); CfD_NonSim_Years_p6(21:24,:)]; %combine 2045 and 2046-2049
 CfD_Rev_Mid_p6 = [CfD_Rev_Mid_p6; CfD_All_p6(7,:)]; %add 2050
 
 CfD_Rev_Fin_p6 = CfD_Rev_Mid_p6';

%interpolate revenues for Sliding Premium

 SP_Delta_p6 = zeros(6,1000);
for j=1:6
      SP_Delta_p6(j,:) = (SP_All_p6(j+1,:) - SP_All_p6(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     SP_Rev_21_49_p6(j,year,:) = SP_All_p6(j,:) + year*SP_Delta_p6(j,:); %revenues between simulation years
   end
 end
 SP_NonSimYears_p6 = zeros(24,1000); %transformed Rev_CfD matrix
 SP_NonSimYears_p6 = squeeze(reshape(permute(SP_Rev_21_49_p6,[2,1,3]),1,24,1000));
 
 SP_Rev_Mid_p6 = zeros(length(SP_NonSimYears_p6(:,1))+length(SP_All_p6(:,1)),1000);
 SP_Rev_Mid_p6 = [SP_All_p6(1,:); SP_NonSimYears_p6(1:4,:)];
 SP_Rev_Mid_p6 = [SP_Rev_Mid_p6; SP_All_p6(2,:); SP_NonSimYears_p6(5:8,:)]; % ...
 SP_Rev_Mid_p6 = [SP_Rev_Mid_p6; SP_All_p6(3,:); SP_NonSimYears_p6(9:12,:)]; % ...
 SP_Rev_Mid_p6 = [SP_Rev_Mid_p6; SP_All_p6(4,:); SP_NonSimYears_p6(13:16,:)]; % ...
 SP_Rev_Mid_p6 = [SP_Rev_Mid_p6; SP_All_p6(5,:); SP_NonSimYears_p6(17:20,:)]; %combine 2040 and 2041-2044
 SP_Rev_Mid_p6 = [SP_Rev_Mid_p6; SP_All_p6(6,:); SP_NonSimYears_p6(21:24,:)]; %combine 2045 and 2046-2049
 SP_Rev_Mid_p6 = [SP_Rev_Mid_p6; SP_All_p6(7,:)]; %add 2050
 
 SP_Rev_Fin_p6 = SP_Rev_Mid_p6';
 
  %interpolate revenues for Merchant
 
 Mer_Delta_p6 = zeros(6,1000);
for j=1:6
      Mer_Delta_p6(j,:) = (Mer_All_p6(j+1,:) - Mer_All_p6(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     Mer_Rev_21_49_p6(j,year,:) = Mer_All_p6(j,:) + year*Mer_Delta_p6(j,:); %revenues between simulation years
   end
 end
 Mer_NonSimYears_p6 = zeros(24,1000); %transformed Rev_CfD matrix
 Mer_NonSimYears_p6 = squeeze(reshape(permute(Mer_Rev_21_49_p6,[2,1,3]),1,24,1000));
 
 Mer_Rev_Mid_p6 = zeros(length(Mer_NonSimYears_p6(:,1))+length(Mer_All_p6(:,1)),1000);
 Mer_Rev_Mid_p6 = [Mer_All_p6(1,:); Mer_NonSimYears_p6(1:4,:)];
 Mer_Rev_Mid_p6 = [Mer_Rev_Mid_p6; Mer_All_p6(2,:); Mer_NonSimYears_p6(5:8,:)]; % ...
 Mer_Rev_Mid_p6 = [Mer_Rev_Mid_p6; Mer_All_p6(3,:); Mer_NonSimYears_p6(9:12,:)]; % ...
 Mer_Rev_Mid_p6 = [Mer_Rev_Mid_p6; Mer_All_p6(4,:); Mer_NonSimYears_p6(13:16,:)]; % ...
 Mer_Rev_Mid_p6 = [Mer_Rev_Mid_p6; Mer_All_p6(5,:); Mer_NonSimYears_p6(17:20,:)]; %combine 2040 and 2041-2044
 Mer_Rev_Mid_p6 = [Mer_Rev_Mid_p6; Mer_All_p6(6,:); Mer_NonSimYears_p6(21:24,:)]; %combine 2045 and 2046-2049
 Mer_Rev_Mid_p6 = [Mer_Rev_Mid_p6; Mer_All_p6(7,:)]; %add 2050
 
 Mer_Rev_Fin_p6 = Mer_Rev_Mid_p6';
 
 %SUMMARY CALCS
 
 %Make mean of all scenarios - to have an idea of the average revenue curve
 MeanCfD_p6 = mean(CfD_Rev_Fin_p6);
 MeanSP_p6 = mean(SP_Rev_Fin_p6);
 MeanMer_p6 = mean(Mer_Rev_Fin_p6);
 
end


 