%creates a list of random lengths of intervals containing exclusively
%positive or negative values; these random interval lengths are distributed
%like corresponding intervals in the input data
%---------
%input arguments:

%diffTimeSeries: time series of hourly changes of the capacity utilisation
%simLength: number of values that later are supposed to be simulated

%output arguments:

%intervalLengths: row vector with variable length; contains the lengths of
    %intervals which are later supposed to include exclusively positive or
    %negative capacity utilisation differences, the sum of all random 
    %interval lengths equals simLength
%---------
%authors: Sebastian Ortlieb
%last update: 07/23/2010
%---------
function [intervalLengths,minMaxIntLength] = rndIntervalLengths(diffTimeSeries, simLength)

%compute the possibility distributions of an all-positive or -negative interval with
%different lengths along diffTimeSeries

%preallocate possibility distribution lists: 1st column - interval length;
%2nd column - number of the intervals; 3rd column - possibility of the
%interval
posIntLengthDist = zeros(1,3);
negIntLengthDist = zeros(1,3);
%numerators for interval lengths
posCount = 0;
negCount = 0;
%go along diffTimeSeries
for i = 1 : length(diffTimeSeries)
    if diffTimeSeries(i) >= 0
        %value is positive
        posCount = posCount + 1;
        indicator = 1;
    else
        %value is negative
        negCount = negCount + 1;
        indicator = -1;
    end
    if (posCount > 0) && (negCount > 0)
        %intervals switch signs
        if indicator < 0
            %last interval was positive
            posIntLengthDist(posCount,1) = posCount;
            posIntLengthDist(posCount,2) = posIntLengthDist(posCount,2) + 1;
            posCount = 0;
        else
            %last interval was negative
            negIntLengthDist(negCount,1) = negCount;
            negIntLengthDist(negCount,2) = negIntLengthDist(negCount,2) + 1;
            negCount = 0;
        end
    end
end
%compute possibility distributions
posIntLengthDist(:,3) = posIntLengthDist(:,2) ./ sum(posIntLengthDist(:,2));
negIntLengthDist(:,3) = negIntLengthDist(:,2) ./ sum(negIntLengthDist(:,2));

%for simplification a general distribution for both all-positive AND
%all-negative intervals is created
minMaxIntLength = min(length(posIntLengthDist(:,3)),...
                length(negIntLengthDist(:,3)));

intLengthDist = (posIntLengthDist(1:minMaxIntLength,3) +...
                 negIntLengthDist(1:minMaxIntLength,3)) ./ 2;
%make sure that the sum of all possibilities equals 1
intLengthDist(length(intLengthDist) + 1) = 1 - sum(intLengthDist);

%preallocate output
intervalLengths = zeros(1,1);

%create suitable interval lengths by comparing random numbers and the
%observed distribution

%stop criterion
notEnoughIntervals = true;

i = 1;
while notEnoughIntervals
    j = 1;
    %compare random uniformly distributed numbers with intLengthDist
    unifrndNumber = unifrnd(0,1);
    while sum(intLengthDist(1:j)) < unifrndNumber
        j = j + 1;
    end
    intervalLengths(i,1) = j;
    %check stop criterion
    if sum(intervalLengths(:,1)) >= simLength
        intervalLengths(i,1) = intervalLengths(i,1) + ...
                               (simLength - sum(intervalLengths(:,1)));
        notEnoughIntervals = false;
    end
    i = i + 1;
end