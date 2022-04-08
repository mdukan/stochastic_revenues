
function [WeeklySeries] = addWeeklyCycle1(DataSeries,WSCoeff,SimYear)
DiffDays = datenum(SimYear,1,1)-datenum(2002,1,1);
DiffHours = 24*DiffDays;
HoursShift = mod(DiffHours,168);

PhaseShift = (41+HoursShift)*pi/168;

L = length(DataSeries);
WL = 168; %Number of hours within a week

SeasonStruct = zeros(L,1);
WeekSeason = zeros(L,1);
for i=1:L
    SeasonStruct (i) = abs(sin((pi/168)*i+PhaseShift));
end;
WeekSeason = SeasonStruct * WSCoeff(2) + WSCoeff(1);

WeeklySeries = DataSeries + WeekSeason;