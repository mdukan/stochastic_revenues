function [EstMdl,residuals]=estimateSolarArima(deseasonalisedY)

%estimate simple autoregressive model for the time series
Mdl = arima('Constant',0,'ARlags',1:1,'D',0,'Seasonality',0); %,'MAlags',1:1

EstMdl = estimate(Mdl,deseasonalisedY);
[residuals,~] = infer(EstMdl,deseasonalisedY);


end