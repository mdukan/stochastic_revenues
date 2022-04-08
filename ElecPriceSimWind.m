clear all;
load Elecprice_wind_PV_11_15-16
%load CapacityUtilisation0611;
load installCapacity0615;

%add the folder with the PV simulation functions to the path
addpath('C:\Mak Folder\PAPERS\Paper C\#3 MATLAB\#5 RUNNING the model\MATLAB_price_model\neue_Skripte');
%load the PV data to the workspace to simulate feed-in
%load('C:\Dogan Keles\Papers\PVStorage\MATLAB-Dateien\PreisprozesseRES\PV profile generator\PV profile generator\pv-production-and-capacity.mat');
%uigetfile();

StartYear = 2011; %Must be at least 2006
EndYear = 2015; %Depend in the data series for hourlyESP06...   
BeginSimYear = 2015; EndSimYear = 2015;
numberSim = 2; 

CN=1; %Number of clusters, to which the number of simulated price and feed-in series are to be reduced
        %Preparation of the input files for the GAMS Stochastic dynamic
        %programming model, CN should be smaller than "numberSim"

L=length(DEElecPrice11_16hourly(1:43824));
BeginData = 24*(datenum(StartYear,1,1)-datenum(2011,1,1))+1;
EndData = 24*(datenum(EndYear,12,31)-datenum(2010,12,31));
Period = BeginData:EndData;
%Period1 = (BeginData-8760):(EndData-8760);

BeginDataVali = 24*(datenum(BeginSimYear,1,1)-datenum(2011,1,1))+1;
EndDataVali = 24*(datenum(EndSimYear,12,31)-datenum(2010,12,31));
PeriodValidation = BeginDataVali :EndDataVali;


BasePrices = DEElecPrice11_16hourly(Period);%hourlyESP0611(Period);
BaseWES = DEWindInfeedExAnte11_15hourly(Period);
%BaseWES(1:500) = BaseWES (1:500);
BasePVES = DESolarInfeedExAnte11_15hourly(Period);

%SimPVCapacity = 55901;  %EU-ReferenceScenario2016: 2025: 55901, 2030: 63959
%SimWindCapacity = 62007; %EU-ReferenceScenario2016: 2025: 62007, 2030: 67214
SimWindCapacity = installCapacity0615(1,2015-2005);
SimPVCapacity = installCapacity0615(2,2015-2005);

%BeginSimData = 24*(datenum(BeginSimYear ,1,1)-datenum(2006,1,1))+1;
%EndSimData = 24*(datenum(EndSimYear ,12,31)-datenum(2005,12,31));
%ComparisonPeriod = BeginData:EndData;ST
%ValidationPrices = hourlyESP0611(ComparisonPeriod(end-8760+1:end));
ValidationPrices = DEElecPrice11_16hourly(PeriodValidation);

%[SimPrices,simulatedWES]= simulateESP(BasePrices,BaseWES,BaseCapUtil,installCapacity,StartYear,SimYear,numberSim);
SimHours=8760;
TotalSimPrices = zeros(SimHours,numberSim,(EndSimYear-BeginSimYear));
SimPriceSeries = zeros(1,numberSim);
SimWindSeries = zeros(1,numberSim);
SimPVSeries = zeros(1,numberSim);
for SimYear=BeginSimYear:EndSimYear
    [SimPrices,SimWind,SimPV,TrendCoeff,WSCoeff,...
    PosProbMatrix,NegProbMatrix,MonthlyMeans]= simulateESP2(BasePrices,...
    BaseWES,BasePVES,installCapacity0615,StartYear,EndYear,SimYear,numberSim,...
    SimPVCapacity,SimWindCapacity);

    SimPriceSeries = [SimPriceSeries;SimPrices];
    SimWindSeries = [SimWindSeries;SimWind];
    SimPVSeries = [SimPVSeries;SimPV];
    TotalSimPrices(:,:,SimYear-BeginSimYear+1) = SimPrices(1:8760,:);
end

save('PricePVresults.mat','SimPriceSeries','SimPVSeries','SimWindSeries'); 
%SimPriceSeries= SimPriceSeries+8;
%%%%%%EVALUATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SortedTSimPrices = sort(TotalSimPrices,1,'descend');
MeanSortPrices = mean(SortedTSimPrices,3);%JORIS: this does change nothing: dimension '3' is not a valid dimension of the simulation matrix! At least at the moment using only one simulation year
STDSimPr = std(SimPriceSeries);
Mean_STDSimPr = mean(STDSimPr);
Mean_SimPrice = mean(mean(SimPriceSeries));
Mean_ValiPrice = mean(ValidationPrices);

[RMSE,MAPE,AverageSortPrices] = QualityMRSE(MeanSortPrices,ValidationPrices);
%simCapUtil=(SimWind/installCapacity(end));
%[RMSE_Wind,MAPE_Wind] = QualityMRSE(simCapUtil,CapacityUtilisation0611);
Mean_RMSE = mean(RMSE);
Mean_MAPE = mean(MAPE);

SimPriceSeries(1,:) = []; 
SimWindSeries(1,:) = [];
SimPVSeries(1,:) = [];

R2 = zeros(numberSim,1);
Period = (SimYear-StartYear)*8760+1:(SimYear+1-StartYear)*8760;
for k=1:numberSim
    R = corrcoef([SimPriceSeries(:,k) ValidationPrices]);
    R2(k) = R(1,2)*R(1,2);
end
Mean_R2 = mean(R2);
SimSkew = skewness(SimPrices);Mean_SimSkew = mean(SimSkew);
SPSkew = skewness(BasePrices); %skewness of histroical prices

SimKurt = kurtosis(SimPrices);Mean_SimKurt = mean(SimKurt);
SPKurt = kurtosis(BasePrices); %skewness of histroical prices

%%%%%PLOT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 SimHours = 8760;
 %subplot(2,1,1);
 %plot((1:SimHours),(SimPriceSeriesWN-SimPriceSeries(end-SimHours+1:end)),'k-','LineWidth',2.0);
 plot((1:SimHours),SimPriceSeries(end-SimHours+1:end),'k-','LineWidth',2.0);
 %plot((1:SimHours),MeanSortPrices,'k-','LineWidth',2.0);
 hold on
 
 %plot((1:SimHours),simulatedWES(end-SimHours+1:end)/1000,'r-','LineWidth',2.0);
 plot((1:SimHours),ValidationPrices(end-SimHours+1:end),'r-','LineWidth',2.0);
 plot((1:SimHours)*TrendCoeff(1) + TrendCoeff(2));
 %plot((1:SimHours),AverageSortPrices,'r-','LineWidth',2.0);
 %legende1 = legend('Price reduction of WPF','simulated WPF in GW',1,'FontSize',14);
 legende1 = legend('Simulierte Preise','Historische Preise','FontSize',14);
 axis([0 8760 -50  200]);
 xlabel('Stunden','FontSize',14)       % Beschriftung der x-Achse
 ylabel('Strompreis [€/MWh]','FontSize',14)  
 set(legende1,'Interpreter','none'),grid off;
 hold off;
 %h=axes;
 %set(h,'Fontsize',14);

 histogram(SimPriceSeries(:,1),'BinWidth',1,'Normalization','probability');
 hold on
 %histogram(SimPriceSeries(:,2),'BinWidth',1,'Normalization','probability');
 %histogram(SimPriceSeries(:,3),'BinWidth',1,'Normalization','probability');
 histogram(ValidationPrices,'BinWidth',1,'Normalization','probability');
 hold off
 
 %Scenario reduction and wirting of GAMS include filesRedPrices
 %add the folder with the PV simulation functions to the path
 addpath('C:\Dogan Keles\Papers\PVStorage\MATLAB-Dateien\Szenarioreduktion');
 SimPVpercentage = SimPVSeries/installCapacity0615(2,SimYear-2005);
 [RedPrices, Prob, TrProb, RedPVF]=ClusterSDP(SimPriceSeries(1:8760,:),SimPVpercentage(1:8760,:),CN);
 
 printMatrix3D(RedPrices,'Table elec_price(d,ps,h)','d','ps','h', 'RedElecPrice2025.inc');
 printMatrix3D2(RedPVF,'Table PVF(d,ps,h)','d','ps','h', 'PVF2025.inc');
 printMatrix3D(TrProb,'Table TransProb(d,ps,pps)','d','ps','ps', 'TransProbability2025.inc');
 printMatrix(Prob,'Table Prob(d,ps)','d','ps','Probability2025.inc');
 
 %subplot(2,1,2);
 %plot((1:SimHours),simulatedWES(1:SimHours),'b-',(1:SimHours),hourlyWES(1:SimHours),'r-');
 %legende2 = legend('Simulated WPF','Historical WPF',1,'FontSize',14);
 %axis([0 8760  0  10000])
 %xlabel('Time in hours','FontSize',14)       % Beschriftung der x-Achse
 %ylabel('Wind power feed-in [MWh]','FontSize',14)  
 %set(legende2,'Interpreter','none'),grid off;

 %plot((1:8760),hourlyWES(1:8760),'r-',(1:8760),simulatedWES(1:8760),'b-');
% STDSimPr = std(SimPrices);
% Mean_STDSimPr = mean(STDSimPr);
% Mean_SimPrice = mean(SimPrices);
% 
% %Maasuring the quality of the Simulated Price Series
% [MRSE,MAPE,AverageSortPrices] = QualityMRSE(SimPrices,BasePrices);
% [wMRSE] = QualityMRSEw(SimPrices,BasePrices);
% Mean_MRSE = mean(MRSE);
% Mean_MAPE = mean(MAPE);
% Mean_wMRSE=mean(wMRSE);
% 
% R2 = zeros(numberSim,1);
% 
% for k=1:numberSim
%     R = corrcoef([SimPrices(:,k) BasePrices]);
%     R2(k) = R(1,2)*R(1,2);
% end
% Mean_R2 = mean(R2);
% SimSkew = skewness(SimPrices);Mean_SimSkew = mean(SimSkew);
% SPSkew = skewness(BasePrices); %skewness of histroical prices
% 
% SimKurt = kurtosis(SimPrices);Mean_SimKurt = mean(SimKurt);
% SPKurt = kurtosis(BasePrices); %skewness of histroical prices