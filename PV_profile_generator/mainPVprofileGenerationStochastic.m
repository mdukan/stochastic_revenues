%this should be the main script running all the procedures!

%procedure is similar to Wagner, A. (2012): Residual demand modeling and
%application to electricity pricing, Berichte des Fraunhofer ITWM.

addpath('C:\Users\ww3988\Documents\3Daten\MATLABData\pv-wind-stochastic\PV profile generator');

year2011=1:365;
year2012=366:731;
year2013=732:1096;
year2014=1097:1461;

%PV capacity end-of-year (MWp)... 
%source: Zeitreihen zur Entwicklung der erneuerbaren Energien in
%Deutschland, BMWi, December 2016
capEnd2010=17944;
capEnd2011=25429;
capEnd2012=33033;
capEnd2013=36337;
capEnd2014=38343;
capEnd2015=39787;


[deseasonalisedY,monthlymean,Y,averageSeasonFit,seasonsFit]=...
    deleteSeasonAndMakeAveragePV(DESolarInfeedExAnte11_15hourly, 2011, 2015, [capEnd2010 capEnd2011 capEnd2012 capEnd2013 capEnd2014]);

[simulatedPVES]=simulatePVES(deseasonalisedY(:,1),averageSeasonFit,monthlymean,capEnd2015);


plot(simulatedPVES);
%plot(feedInContinous .* capEnd2012);
