function NewStochasticSeries = RetransformNormDis(NormSeries,OrderedSeries)
    
    NormCDFSeries = normcdf(NormSeries,0,1);
    IX1 = zeros(length(NormCDFSeries),1);
    NewStochasticSeries =zeros(length(NormCDFSeries),1);
    
    for i = 1:length(NormCDFSeries)
        IX1(i) = length(OrderedSeries)*NormCDFSeries(i); %Equal to length(StochaticSeries)
        NewStochasticSeries(i) = OrderedSeries(int16(ceil(IX1(i))));
    end
end