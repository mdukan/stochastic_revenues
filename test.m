rng default;  % for reproducibility
failuretime = random('wbl',3,1,15,1);

[NormSeries,IX,OrderedSeries]=TransformNormDis(failuretime);

NewStochasticSeries = RetransformNormDis(NormSeries,OrderedSeries);