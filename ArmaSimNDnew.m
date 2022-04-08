% ARMA-Process
% -------------------------------------------------------------
function [SimSeries] = ArmaSimNDnew(P,Q,StochasticSeries,SimYear,numberSim)
% Estimation of the parameters with garchfit
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    [NormSeries,IX,OrderedSeries] = TransformNormDis(StochasticSeries);    

    SimHours = 24*(datenum(SimYear,12,31)-datenum(SimYear-1,12,31));
    ARMA_p = P; ARMA_q = Q;
    c = max(ARMA_p,ARMA_q);
    
    %%%%this is for estimating 24 models: one for every hour of the day...
    %StochSeriesHourly=reshape(NormSeries,24,size(NormSeries,1)/24)';
    %%%%
    
    Mdl = arima('Constant',0,'ARLags',1:ARMA_p,'MALags',1:ARMA_q,'D',0,'Seasonality',0);
    Mdl.Distribution='Gaussian';
    
    %%%%this is for estimating 24 models: one for every hour of the day...
    %EstMdl = cell(24,1);
    %for hour=1:24
    %EstMdl{hour,1} = estimate(Mdl,StochSeriesHourly(:,hour));
    %end
    %%%%
    EstMdl = estimate(Mdl,NormSeries);%NormSeries
% -------------------------------------------------------------
    % Simulation:
    SimSeries = zeros(SimHours,numberSim);
    for k=1:numberSim
        %%%%this is for estimating 24 models: one for every hour of the day...
        %y=zeros(SimHours/24,24);
        %for i=1:24
            %y(:,i)= simulate (EstMdl{i,1},SimHours/24);
        %end
        %hourlySimReshape=reshape(y',[],1);
        %%%%
        
        y = simulate (EstMdl,SimHours);
        
        %orderedY=sort(hourlySimReshape); 
        NewStochasticSeries = RetransformNormDis(y,OrderedSeries); %y hourlySimReshape
        SimSeries (:,k) = NewStochasticSeries;    
    end;
end