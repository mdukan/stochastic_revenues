function [bimod] = bimodrnd(seriesNeg)
    series=abs(seriesNeg);
    Lseries = length(series);
    series1=zeros();
    series2=zeros();
    
    % Disagregation into the two price intervals <80 and >=80
    k=1;j=1;
    for i=1:Lseries
        if series(i)<=80
            series1(k)=series(i);
            k=k+1;
        else
            series2(j)=series(i);
            j=j+1;
        end
    end
    
    %Removal of outliers from series2
    stdS2 =std(series2);meanS2= mean(series2);
    L=length(series2);
    i=1;
    while i<L
        if series2(i)<(meanS2-2*stdS2)||series2(i)>(meanS2+2*stdS2)
            series2(i)=[];
            L=L-1;
        end
        i=i+1;
    end 
    
    %Exponential distribution of the first interval negative series
    mu1 = expfit(series1);
    %Normal distribution of the second interval negative series
    phat=mle(series2,'distribution','lognormal');   
    Prob_series1 = length(series1)/(length(series1)+length(series2));
    
    %Uniformly distributed random decision variable for the selection of
    %the distribution from above
    distRD = rand();
    
    %Generation of the bimodal random variable
    if distRD <= Prob_series1
        bimod = exprnd(mu1);
    else
        bimod = lognrnd(phat(1), phat(2));
    end
    bimod = -bimod;
end

%for i=1:100 y(i) = bimodrnd(NegPrices); end;
%hist(y,-200:2:0);figure(gcf);axis([-200 0 0  30]);
%hist(x,-200:2:0);figure(gcf);axis([-200 0 0  30]);

