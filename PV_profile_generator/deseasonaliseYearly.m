%deseasonalize data with sin and cosine and use logit approach and
%distribution

function [deseasonalisedY,Y,betaSeasonFit]=deseasonaliseYearly(feedIn,capacity)


%use logit transformation to get gaussian distribution, normalize with
%installed capacity, concentrate on daily max. The daily shape is defined
%elswhere
maxProcess=max(feedIn./capacity,[],2);

Y= logit(maxProcess);

%set starting values for nonlinear fitting! It's quite important to have
%good starting values!!
beta0= [1.5 (1/365) 1 (1/365) 1 1 1];

moving=movavg(Y,1,1,0);

%make a non linear fit with the defined function
[beta,residuals,J,covB,MSE,ErrorModelInfo]=nlinfit(1:size(feedIn,1),moving,@trigoFit,beta0);

%calculate the confidence intervals
ci=nlparci(beta,residuals,'covar',covB);
%quote 'if confidence intervals do not contain 0, ignore warning on the
%jacobian'

seasons=trigoFit(beta,1:size(feedIn,1));

%cut off one day if it is a leapyear, it doesnt matter anyways!
if size(Y,1)==366
    Y=Y(1:365,:);
    residuals=residuals(1:365,:);
end

%return values: beta of estimated function and deseasonalised time series
deseasonalisedY = residuals;
betaSeasonFit=beta;

%hold on 
%plot(Y);
%plot(seasons);
%plot(deseasonalisedY);
%hold off

%autocorr(deseasonalisedY);
%histfit(deseasonalisedY);

end
