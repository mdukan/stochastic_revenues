function CapUtilization = CapUtil(BaseSeries,NumberYears,installCapacity1)

    BaseSeriesHelp = reshape(BaseSeries(1:(NumberYears*8760)),8760,NumberYears);
    CapUtilizationHelp = zeros(length(BaseSeriesHelp),NumberYears); 
    for i=1:NumberYears
        CapUtilizationHelp(:,i) = BaseSeriesHelp(:,i)/installCapacity1(i);
    end
    CapUtilization = reshape(CapUtilizationHelp,length(BaseSeriesHelp)*NumberYears,1);
end



