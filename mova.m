%identifys the lag for which the dependency between the moving average
%(called the level) of the capacity utilisation and the following
%rate of change is the most significant; starting at lag 1 up to maxlag
%---------
%input arguments:

%CapacityUtilisation: observed capacity utilisation of the total installed
    %wind energy feed-in capacity (hourly values)
%maxlag: maximum moving average lag for which the dependency between the
    %resulting moving average and the rate of change is tested
    
%output arguments:

%MovavgLag: scalar; optimal moving average lag with the most significant
    %dependency between capacity utilisation level and rate of change
%---------
%authors: Sebastian Ortlieb
%last update: 07/23/2010
%---------
function [MovavgLag] = mova(CapacityUtilisation, maxlag)

%create first order differences
diffCapacity = diff(CapacityUtilisation);
%compute dependencies using linear regression 
RList = zeros(maxlag, 1);
for lag = 1:maxlag
    ma = tsmovavg(CapacityUtilisation, 's', lag, 1);    
    x = ma(lag:length(diffCapacity));
    y = diffCapacity(lag:length(diffCapacity));
    
    R = corrcoef(x,y);
    RList(lag,1) = R(1,2);
end
%identify best lag
[MaximumRLag, index] = max(abs(RList(:,1)));
MovavgLag = index(1);