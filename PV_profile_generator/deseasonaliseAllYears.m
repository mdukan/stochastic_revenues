%deseasonalize data with sin and cosine and use logit approach and
%distribution

function [deseasonalisedY,Y,betaSeasonFit,seasons]=deseasonaliseAllYears(feedIn,capacity)

solarFeedIn24hours=reshape(feedIn,24,size(feedIn,1)/24)';
%use logit transformation to get gaussian distribution, normalize with
%installed capacity, concentrate on daily max. The daily shape is defined
%elswhere
Y=[];
for i=1:5
    p=0;
    k=0;
    if i==2
        p=0;
        k=1;
    end
    if i>=3
        k=1;
        p=1;
    end
    
    X= logit(max(solarFeedIn24hours(365*(i-1)+1 + p*k*1:365*i + k*1,:)./capacity(i),[],2));
    Y=[Y;X];
end
%set starting values for nonlinear fitting
beta0= [1.5 (1/365) 1 (1/365) 1 1 1];

%movmean(Y,7);

%make a non linear fit with the defined function
[beta,residuals,J,covB,MSE,ErrorModelInfo]=nlinfit(1:size(Y,1),Y,@trigoFit,beta0);


%calculate the confidence intervals
ci=nlparci(beta,residuals,'covar',covB);
%quote 'if confidence intervals do not contain 0, ignore warning on the
%jacobian'

seasons=trigoFit(beta,1:size(Y,1));

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