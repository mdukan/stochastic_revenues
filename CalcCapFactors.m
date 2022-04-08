WindGenMatrix = reshape(DEWindInfeedExAnte11_15hourly(1:9*8760),8760,9);
MaxGen = max(WindGenMatrix);
hourlyCapFactors = zeros(8760,9);
for i =1:9
    for j=1:8760
       hourlyCapFactors(j,i) = WindGenMatrix(j,i)/installCapacity0650(1,i+5);
    end
end

MaxCapF = max(hourlyCapFactors);

MeanCapF = mean(hourlyCapFactors);


%hourlyCapFOffPlant = 

%Index = hourlyCapFOffPlant/hourlyCapFactors;