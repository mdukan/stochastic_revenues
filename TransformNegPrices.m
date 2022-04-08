%Function to transform negative Prices into positive ones and to determine
%their probabilitiy

function [ProbNegPrices,TransformedPrices, NegPrices]= TransformNegPrices(DataSeries,StartYear) 
numberNegPrices = 0;
TransformedPrices = zeros(length(DataSeries),1);
for i=1:length(DataSeries)
    if DataSeries(i)<=0
        TransformedPrices(i) = 0.01;
        numberNegPrices = numberNegPrices+1;
        NegPrices(numberNegPrices) = DataSeries(i);
    else
        TransformedPrices(i) = DataSeries(i);
    end
end;

%Determining the probability of the negative Prices within the time of 
LData = length(DataSeries);
NumberYears = floor(LData/8760);
YearsWithNegPrices = StartYear+NumberYears-2008; %Negative Prices since 1.1.2008

if YearsWithNegPrices>0
    ProbNegPrices = numberNegPrices/((YearsWithNegPrices-0.66)*8760);
else
    ProbNegPrices = 0;
end