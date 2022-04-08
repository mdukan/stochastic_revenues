clear all;
load data_package_model_fin_2
load installCapacity0650;
load fundamental_price_level; %STEP1: define price scenario (align variable names this file, and functions simulateESP3 and addTrend)

%add the folder with the PV simulation functions to the path
addpath('C:\Mak\Github\PreisprozesseRES\PV_profile_generator'); %STEP2: insert file path to PV_profile_generator

StartYear = 2016; %STEP3a): define start year for historical data (must be at least 2006)
EndYear = 2019; %STEP3b): define end year of historical data (depend in the data series for hourlyESP06...)  
BeginSimYear = 2020; EndSimYear = 2020;% STEP4: begin and end year must be the same !! if this is not a leap year, number of hours 8760 !!
numberSim = 1; % STEP5: define number of simulated scenarios 
SimHours=8784; % STEP6: define the number of hours (8784 for leap year and 8760 for non-leap year)

CN=1; %Number of clusters, to which the number of simulated price and feed-in series are to be reduced
        %Preparation of the input files for the GAMS Stochastic dynamic
        %programming model, CN should be smaller than "numberSim"

L=length(DEElecPrice11_16hourly(1:43824));
BeginData = 24*(datenum(StartYear,1,1)-datenum(2011,1,1))+1;
EndData = 24*(datenum(EndYear,12,31)-datenum(2010,12,31));
Period = BeginData:EndData;

BeginDataVali = 24*(datenum(BeginSimYear,1,1)-datenum(2011,1,1))+1;
EndDataVali = 24*(datenum(EndSimYear,12,31)-datenum(2010,12,31));
PeriodValidation = BeginDataVali:EndDataVali;


BasePrices = DEElecPrice11_16hourly(Period);%hourlyESP0611(Period);
BaseWES = DEWindInfeedExAnte11_15hourly(Period);
BasePVES = DESolarInfeedExAnte11_15hourly(Period);

ValidationPrices = DEElecPrice11_16hourly(PeriodValidation);

TotalSimPrices = zeros(SimHours,numberSim,(EndSimYear-BeginSimYear));
SimPriceSeries = zeros(1,numberSim);
SimWindSeries = zeros(1,numberSim);
SimPVSeries = zeros(1,numberSim);
for SimYear=BeginSimYear:EndSimYear
    
    SimWindCapacity = installCapacity0650(1,SimYear-2005);
    SimPVCapacity = installCapacity0650(2,SimYear-2005);
    
    [SimPrices,SimWind,SimPV,TrendCoeff,WSCoeff,...
    PosProbMatrix,NegProbMatrix,MonthlyMeans]= simulateESP3(BasePrices,...
    BaseWES,BasePVES,installCapacity0650,StartYear,EndYear,SimYear,numberSim,...
    SimPVCapacity,SimWindCapacity,fundamental_price_level);

    SimPriceSeries = [SimPriceSeries;SimPrices];
    SimWindSeries = [SimWindSeries;SimWind];
    SimPVSeries = [SimPVSeries;SimPV];
    TotalSimPrices(:,:,SimYear-BeginSimYear+1) = SimPrices(1:SimHours,:);
end

save('PricePVresults.mat','SimPriceSeries','SimPVSeries','SimWindSeries'); 
%%%%%%EVALUATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SortedTSimPrices = sort(TotalSimPrices,1,'descend');
MeanSortPrices = mean(SortedTSimPrices,3);
STDSimPr = std(SimPriceSeries);
Mean_STDSimPr = mean(STDSimPr);
Mean_SimPrice = mean(mean(SimPriceSeries));
Mean_ValiPrice = mean(ValidationPrices);

[RMSE,MAPE,AverageSortPrices] = QualityMRSE(MeanSortPrices,ValidationPrices);
Mean_RMSE = mean(RMSE);
Mean_MAPE = mean(MAPE);

SimPriceSeries(1,:) = []; 
SimWindSeries(1,:) = [];
SimPVSeries(1,:) = [];

R2 = zeros(numberSim,1);
Period = (SimYear-StartYear)*SimHours+1:(SimYear+1-StartYear)*SimHours;
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
 SimHoursPlot = SimHours;
 plot((1:SimHoursPlot),SimPriceSeries(end-SimHoursPlot+1:end),'k-','LineWidth',2.0);
 hold on
 
 axis([0 SimHoursPlot -50  200]);
 xlabel('hours','FontSize',14)       % Beschriftung der x-Achse
 ylabel('elec price [€/MWh]','FontSize',14)  
 hold off;
 
  