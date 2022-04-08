clear all;
addpath ('C:\Mak\000000  MATLAB MAIN FOLDER 000000\MATLAB_outputs\#R001_AggRev_Sep_All'); %need to add part because code is in diff folder
load CfD_R001_All; %takes individual agg rev files and loads them
load SP_R001_All %...
load Merchant_R001_All %...

%create one matrix for each revenue type
CfDComb = [Aggregated_CfDRevenues2020;Aggregated_CfDRevenues2025;Aggregated_CfDRevenues2030;Aggregated_CfDRevenues2035;...
    Aggregated_CfDRevenues2040;Aggregated_CfDRevenues2045;Aggregated_CfDRevenues2050]; 

SPComb = [Aggregated_SlidingPremiumRevenues2020;Aggregated_SlidingPremiumRevenues2025;Aggregated_SlidingPremiumRevenues2030;Aggregated_SlidingPremiumRevenues2035;...
     Aggregated_SlidingPremiumRevenues2040;Aggregated_SlidingPremiumRevenues2045;Aggregated_SlidingPremiumRevenues2050]; 
 
MerComb = [Aggregated_MerchantRevenues2020;Aggregated_MerchantRevenues2025;Aggregated_MerchantRevenues2030;Aggregated_MerchantRevenues2035;...
    Aggregated_MerchantRevenues2040;Aggregated_MerchantRevenues2045;Aggregated_MerchantRevenues2050];

%interpolate revenues for CfD

CfDComb_Delta = zeros(6,1000);
 YearDiff = 5;
for j=1:6
      CfDComb_Delta(j,:) = (CfDComb(j+1,:) - CfDComb(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     Rev_CfD_2021to2049(j,year,:) = CfDComb(j,:) + year*CfDComb_Delta(j,:); %revenues between simulation years
   end
 end
 Rev_CFD_inty = zeros(24,1000); %transformed Rev_CfD matrix
 Rev_CFD_inty = squeeze(reshape(permute(Rev_CfD_2021to2049,[2,1,3]),1,24,1000));
 
 Rev_CFD_ally = zeros(length(Rev_CFD_inty(:,1))+length(CfDComb(:,1)),1000);
 Rev_CFD_ally = [CfDComb(1,:); Rev_CFD_inty(1:4,:)];
 Rev_CFD_ally = [Rev_CFD_ally; CfDComb(2,:); Rev_CFD_inty(5:8,:)]; % ...
 Rev_CFD_ally = [Rev_CFD_ally; CfDComb(3,:); Rev_CFD_inty(9:12,:)]; % ...
 Rev_CFD_ally = [Rev_CFD_ally; CfDComb(4,:); Rev_CFD_inty(13:16,:)]; % ...
 Rev_CFD_ally = [Rev_CFD_ally; CfDComb(5,:); Rev_CFD_inty(17:20,:)]; %combine 2040 and 2041-2044
 Rev_CFD_ally = [Rev_CFD_ally; CfDComb(6,:); Rev_CFD_inty(21:24,:)]; %combine 2045 and 2046-2049
 Rev_CFD_ally = [Rev_CFD_ally; CfDComb(7,:)]; %add 2050
 
 CfD_FinalRev = Rev_CFD_ally';

%interpolate revenues for Sliding Premium

 SPComb_Delta = zeros(6,1000);
for j=1:6
      SPComb_Delta(j,:) = (SPComb(j+1,:) - SPComb(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     Rev_SP_2021to2049(j,year,:) = SPComb(j,:) + year*SPComb_Delta(j,:); %revenues between simulation years
   end
 end
 Rev_SP_inty = zeros(24,1000); %transformed Rev_CfD matrix
 Rev_SP_inty = squeeze(reshape(permute(Rev_SP_2021to2049,[2,1,3]),1,24,1000));
 
 Rev_SP_ally = zeros(length(Rev_SP_inty(:,1))+length(SPComb(:,1)),1000);
 Rev_SP_ally = [SPComb(1,:); Rev_SP_inty(1:4,:)];
 Rev_SP_ally = [Rev_SP_ally; SPComb(2,:); Rev_SP_inty(5:8,:)]; % ...
 Rev_SP_ally = [Rev_SP_ally; SPComb(3,:); Rev_SP_inty(9:12,:)]; % ...
 Rev_SP_ally = [Rev_SP_ally; SPComb(4,:); Rev_SP_inty(13:16,:)]; % ...
 Rev_SP_ally = [Rev_SP_ally; SPComb(5,:); Rev_SP_inty(17:20,:)]; %combine 2040 and 2041-2044
 Rev_SP_ally = [Rev_SP_ally; SPComb(6,:); Rev_SP_inty(21:24,:)]; %combine 2045 and 2046-2049
 Rev_SP_ally = [Rev_SP_ally; SPComb(7,:)]; %add 2050
 
 SP_FinalRev = Rev_SP_ally';
 
  %interpolate revenues for Merchant
 
 MerComb_Delta = zeros(6,1000);
for j=1:6
      MerComb_Delta(j,:) = (MerComb(j+1,:) - MerComb(j,:))/YearDiff;
end

 for j = 1:6 % steps between the simulation years
   for year = 1:4 % number of years between two simulation years
     Rev_Mer_2021to2049(j,year,:) = MerComb(j,:) + year*MerComb_Delta(j,:); %revenues between simulation years
   end
 end
 Rev_Mer_inty = zeros(24,1000); %transformed Rev_CfD matrix
 Rev_Mer_inty = squeeze(reshape(permute(Rev_Mer_2021to2049,[2,1,3]),1,24,1000));
 
 Rev_Mer_ally = zeros(length(Rev_Mer_inty(:,1))+length(MerComb(:,1)),1000);
 Rev_Mer_ally = [MerComb(1,:); Rev_Mer_inty(1:4,:)];
 Rev_Mer_ally = [Rev_Mer_ally; MerComb(2,:); Rev_Mer_inty(5:8,:)]; % ...
 Rev_Mer_ally = [Rev_Mer_ally; MerComb(3,:); Rev_Mer_inty(9:12,:)]; % ...
 Rev_Mer_ally = [Rev_Mer_ally; MerComb(4,:); Rev_Mer_inty(13:16,:)]; % ...
 Rev_Mer_ally = [Rev_Mer_ally; MerComb(5,:); Rev_Mer_inty(17:20,:)]; %combine 2040 and 2041-2044
 Rev_Mer_ally = [Rev_Mer_ally; MerComb(6,:); Rev_Mer_inty(21:24,:)]; %combine 2045 and 2046-2049
 Rev_Mer_ally = [Rev_Mer_ally; MerComb(7,:)]; %add 2050
 
 Mer_FinalRev = Rev_Mer_ally';
 
 
 
 