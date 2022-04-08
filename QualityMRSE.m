% function to determine the quality of the simulation (mean root squared error)

function [RMSE,MAPE,MeanSortRPMatrix] = QualityMRSE(SimSeries,RealSeries)

numberSim = length(SimSeries(1,:));
AnalysedSimSeries = SimSeries(1:8760,:);

RealSeriesLength = length(RealSeries);
NumberRYears = floor(RealSeriesLength/8760);

AnalysedRealSeries = RealSeries(1:(8760*NumberRYears));
RealSeriesMatrix = reshape(AnalysedRealSeries,8760,NumberRYears);
    
SortRPMatrix = sort(RealSeriesMatrix,1,'descend');
MeanSortRPMatrix = mean(SortRPMatrix,2);

SortSimSeries = sort(AnalysedSimSeries,1,'descend');
% SortSimPreis_letzt = SimPreise(1:8760,1);

RMSE = zeros(numberSim,1);
MAPE = zeros(numberSim,1);
meanSortRP =mean((MeanSortRPMatrix(6:8760,1)));
for k=1:numberSim
    MAPE(k) = sum(abs(MeanSortRPMatrix(6:8760,1)-SortSimSeries(6:8760,k)))/(8755*meanSortRP);
    RMSE(k) = sqrt (1/8755 * sum((MeanSortRPMatrix(6:8760,1)-SortSimSeries(6:8760,k)).^2));
end

    MAPEa = 0;
    for i=1:8760
        if MeanSortRPMatrix(i,1)>2
            MAPEa=MAPEa+abs(MeanSortRPMatrix(i,1)-SortSimSeries(i,k))/MeanSortRPMatrix(i,1);
        end
    end
    MAPEa = MAPEa/8760;
    MAPE(k)=MAPEa;