function [NormSeries,IX,OrderedSeries] = TransformNormDis(StochasticSeries)
    %StochasticSeries = ResidualSeriesNoJumps;
    OrderedSeries = zeros(length(StochasticSeries),2);
    %returns the index matrix of the sorting process as IX as well..
    [OrderedSeries,IX] = sort(StochasticSeries);
    
    CDFempiricSeries = zeros(length(StochasticSeries),1);
    NormInvSeries = zeros(length(StochasticSeries),1);
    
    %[ CDFempiricSeries,orderedX] = ecdf(StochasticSeries);
    
    for i=1:length(StochasticSeries)
        CDFempiricSeries(i) = i/length(StochasticSeries);
    end
    NormInvSeries = norminv(CDFempiricSeries,0,1);
    
    NormInvSeries(length(StochasticSeries))=NormInvSeries(length(StochasticSeries)-1)+0.01;
    
    %this just sorts the time series again...
    NormSeries = zeros(length(StochasticSeries),1);
    for i=1:length(StochasticSeries)
        NormSeries(IX(i)) = NormInvSeries(i);
    end
end

%Norm1Series1 = randn(length(NormSeries),1);
