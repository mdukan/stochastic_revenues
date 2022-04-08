%simulate wind and pv feed in from historic data



solarDE24hours;


D24 = LagOp({1 -1},'Lags',[0,24]);

solarDiff= diff(solarDE24hours(summer, 13));
solarDiff1= diff(solarDE24hours(summer, 12));
%solarDiff=D24(DESolarInfeedExAnte11_14hourly);

%D is the integration lag, 
Mdl = arima('Constant',0,'ARlags',1:1,'D',0,'Seasonality',0,'MAlags',1:1);

%?? whats that??  regARIMA

%(autoregressiveDegree,integrationDegree,0);

fitrange=400;

EstMdl = estimate(Mdl,solarDiff(1:fitrange),'X', solarDiff1(1:fitrange+1));

[YF,YMSE] = forecast(EstMdl,size(solarDiff,1)-fitrange,'Y0',solarDiff(1:fitrange), 'X0',solarDiff1(1:fitrange),'XF',solarDiff1(size(solarDiff,1)-fitrange:end));

%[YF,YMSE] = simulate(EstMdl,size(solarDiff,1)-fitrange,'Y0',solarDiff(1:fitrange), 'E0', 1: );

Y=solarDiff;

figure
h1 = plot(Y,'Color',[.7,.7,.7]);
hold on
h2 = plot(fitrange+1:size(solarDiff,1),YF,'b','LineWidth',2);
h3 = plot(fitrange+1:size(solarDiff,1),YF + 1.96*sqrt(YMSE),'r:',...
		'LineWidth',2);
plot(fitrange+1:size(solarDiff,1),YF - 1.96*sqrt(YMSE),'r:','LineWidth',2);
legend([h1 h2 h3],'Observed','Forecast',...
		'95% Confidence Interval','Location','NorthWest');
title(['30-Period Forecasts and Approximate 95% '...
			'Confidence Intervals'])
hold off