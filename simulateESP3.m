%author: Dogan Keles
%last update: 30.09.2021.
function [SimPrices,SimWind,SimPV,...
    TrendCoeff,WSCoeff,PosProbMatrix,NegProbMatrix,MonthlyMeans] = simulateESP3(BasePrices,...
        hourlyWES, hourlyPVES, installCapacity,StartYear,EndYear,SimYear,numberSim,...
        SimPVCapacity,SimWindCapacity,fundamental_price_level);   

%Remove Wind and PV merit-order effect, WPVESdelPrices are prices adjusted
%by the wind and PV effect
 %[WPVESdelPrices,PVESdelPrices,WESdelPrices,LRCoeffsWES,LRCoeffsPVES,HelpMatrixDelWES,...
 %HelpMatrixDelPVES] = delWPVES(BasePrices((SimYear-StartYear)*8760+1:(SimYear-StartYear+1)*8760),...
 %                      hourlyWES((SimYear-StartYear)*8760+1:(SimYear-StartYear+1)*8760),...
 %                      hourlyPVES((SimYear-StartYear)*8760+1:(SimYear-StartYear+1)*8760), StartYear);
                   
 [WPVESdelPrices,PVESdelPrices,WESdelPrices,LRCoeffsWES,LRCoeffsPVES,HelpMatrixDelWES,...
 HelpMatrixDelPVES] = delWPVES(BasePrices,...
                       hourlyWES,...
                       hourlyPVES, StartYear);
%

%Remove trend and Deseasonalisation
%[ProbNegPrice,TransformedPrices,NegPrices] = TransformNegPrices(WPVESdelPrices,StartYear);
%LogPrice = log(TransformedPrices);
TransformedPrices = WPVESdelPrices;

[DetLogPrice, TrendCoeff] = delTrend(TransformedPrices);
[AnnualDesSeries, MonthlyMeans] = delAnnualCycle3(DetLogPrice); 
[WeeklyDesSeries, WSCoeff, WeekSeason] = delWeeklyCycle1(AnnualDesSeries,StartYear);
[DailyDesSeries, dailySeason, WeekendHourlyMeans,hourlyMeans] = delDailyCycle3(WeeklyDesSeries,StartYear,SimYear); 

ResidualStochasticSeries = DailyDesSeries;

%Switching Regime: Calculation of Transition Probabilities and Generating
%of series without jumps as well as jump series
[ResidualSeriesNoJumps, PosJumps, NegJumps, PosProbMatrix, NegProbMatrix,...
LOOPSforJumps] = RSProbabilities(ResidualStochasticSeries);

%%%%%%%%%%%%%%%SIMULATION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SimHours = 24*(datenum(SimYear,12,31)-datenum(SimYear-1,12,31));
delta = zeros(SimHours,1);
SimPrices = zeros(SimHours,numberSim);
SimWind= zeros(SimHours,numberSim);
SimPV = zeros(SimHours,numberSim);
SimStochasticComponent = zeros(SimHours,1);
%Heteroscedasticity = archtest(ResidualSeriesNoJumps,1,0.01);

STD_StochComp=zeros(numberSim,1);
     
%%%%%Simulation of the stochastic component based on the residual base series
%[SimStochasticComponentWOJ,mu,sigma] = MeanReversionSim(ResidualSeriesNoJumps,SimYear,numberSim);
[SimStochasticComponentWOJ] = ArmaSimNDnew(5,1,ResidualSeriesNoJumps,SimYear,numberSim);
%[SimStochasticComponentWOJ,Innovations,Coeff,mu,sigma] = ArImaSimLD(5,1,1,ResidualSeriesNoJumps,SimYear,numberSim);
%[Innovations,sigma,SimStochasticComponentWOJ,Coeff,mu] = GarchSimNeu(5,5,ResidualSeriesNoJumps,SimYear,numberSim);

    %%%%%%%%%%%%% PV pre-simulation data provision:
    [deseasonalisedY,dailyCycle,yearlyCycle,seasonsFit,Y]=...
    deseasonaliseYearlyDailyPV(hourlyPVES, StartYear, EndYear, installCapacity );
    %capacity at the end of the previous year is used for a specific year
    %to account for the fact that most capacity is built at the end of a
    %year is avalaible then for the next year
    EstMdlSolar=estimateSolarArima(deseasonalisedY);
    
    dailyMeanCycle=monthlyMeanProfile(dailyCycle,SimHours/24);
    %%%%%%%%%%%%%
    
for i = 1:numberSim    
    
    %Determining the regime for each hour of the simualtion year:
    delta = getRegimeNew(PosProbMatrix, NegProbMatrix, SimYear);
    SimStochasticComponent = addJumps(SimStochasticComponentWOJ(:,i),PosJumps,NegJumps,delta);
    
    STD_StochComp(i) = std(SimStochasticComponent);%standard deviation of the stochastic component
    
    %Adding deterministic components:
    SimDailySeries = addDailyCycle3(SimStochasticComponent,dailySeason, WeekendHourlyMeans,SimYear);
    SimWeeklySeries = addWeeklyCycle1(SimDailySeries,WSCoeff,SimYear);
    SimAnnualSeries = addAnnualCycle3(SimWeeklySeries,MonthlyMeans);
        
    
    %SimPriceSeries = SimAnnualSeries;
    %Retarnsformation of the simulated log prices and diffusion of negative
    %prices
    
    SimPriceSeriesWN = SimAnnualSeries;
    %SimPriceSeriesWN = RetransformNegPrices(SimPriceSeriesWoN, delta, ProbNegPrice,NegPrices);
    for j=1:SimHours
        if SimPriceSeriesWN(j)>3000
            SimPriceSeriesWN(j)=3000;
        end
    end
    
    %simulate wind energy feed-in:
    CapUtilization = CapUtil(hourlyWES,...
        EndYear-StartYear+1,installCapacity(1,StartYear-2006:end));
    [simulatedWES] = simulateWES(CapUtilization,...
                                 SimWindCapacity,SimYear);
    %((SimYear-StartYear)*8760:(SimYear-StartYear+1)*8760)
    
    %simulate PV series:
    %yearlyCycle
   %[simulatedPVES]=simulatePVES(yearlyCycle,dailyCycle,SimPVCapacity,...
   %                            SimHours/24,EstMdlSolar,dailyMeanCycle);
    

       [simulatedPVES]=simulatePVES(yearlyCycle,SimPVCapacity,...
                                SimHours/24,EstMdlSolar,dailyMeanCycle); 
       
      [WPVESaddedSeries,PVESaddedSeries,WESaddedSeries] = addWPVES(SimPriceSeriesWN,...
      simulatedWES,simulatedPVES, LRCoeffsWES, LRCoeffsPVES, SimYear);

  [Simstart,SimPriceSeries] = addTrend(WPVESaddedSeries,TrendCoeff,StartYear,SimYear,fundamental_price_level); 

    %SimSComponent = exp(SimStochasticComponent);  
    SimPrices(:,i) =  SimPriceSeries(:,1);
    SimWind(:,i) = simulatedWES;
    SimPV(:,i) = simulatedPVES; 
end
end