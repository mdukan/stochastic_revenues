function [vola,DiffSeries,Deltas]  = volatility(Series)

    DiffSeries=diff(Series);
    Deltas = zeros(length(DiffSeries),1);
    
    for i=1:length(DiffSeries)
        Deltas(i) = DiffSeries(i)/mean(Series);
    end
    vola=std(Deltas);
end