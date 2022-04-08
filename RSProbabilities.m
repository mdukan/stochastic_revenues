% zu übergeben: stündlicher Strompreisvektor und der Wochentag, mit dem der
% übergebene Strompreisvektor beginnt (1:Montag,...7:Sonntag, hier also
% z.B. 2 für Dienstag)
% Rückgabe: um Sprünge bereinigter Strompreisvektor: StrompreisLog
% positiver- und negativer Sprungvektor
% Wahrscheinlichkeitsmatrix für das Auftreten positiver sowie negativer
% Sprünge.

% xyz soll nur die Anzahl der Scheifendurchläufe zählen, bis der Vektor bei
% der Sprungbereinigung konvergiert. Desweiteren soll sie eine
% Endloschleife verhindern, in dem sie die Schleifendurchläufe auf 50
% begrenzt.
% -------------------------------------------------------------------
function [StrompreisLog SprungVektorPositiv SprungVektorNegativ ...
            PositivT NegativT AnzahlSchleifenDurchlaeufe]...
            = RSProbabilities(StromPreisLogNachTrendSaison)

% ---------------------------------------------------------
% ---------------------------------------------------------
% Anzahl Sprünge je Wochentag sowie je Stunde 
% sowie je Jahrezeit bestimmen:
% ---------------------------------------------------------
% ---------------------------------------------------------

% ---------------------------------------------------------
% Grenzwerte für "Sprünge"/Regime festlegen:
StrompreisLog=StromPreisLogNachTrendSaison;
StrompreisLaenge=length(StrompreisLog);

% ---------------------------------------------------------
% bestimmen der Indizes für Stunden
k=0;
for i=1:24:StrompreisLaenge
    k=k+1;
    for j=1:24
        Stunden(j,k)=(i-1)+j;
    end;
end;

% ---------------------------------------------------------
% Bestimmen der Indizes für Wochentage
w=zeros(7,1);

hilfsvariable=datenum(2002,1,1)-1;

for i=datenum(2002,1,1):datenum(2008,12,31)
    if weekday(i)==1
        w(1)=w(1)+1;
        So(w(1))=i-hilfsvariable;
    elseif weekday(i)==2
        w(2)=w(2)+1;        
        Mo(w(2))=i-hilfsvariable;
    elseif weekday(i)==3
        w(3)=w(3)+1;        
        Di(w(3))=i-hilfsvariable;        
    elseif weekday(i)==4
        w(4)=w(4)+1;        
        Mi(w(4))=i-hilfsvariable;                
    elseif weekday(i)==5
        w(5)=w(5)+1;        
        Do(w(5))=i-hilfsvariable;
    elseif weekday(i)==6
        w(6)=w(6)+1;        
        Fr(w(6))=i-hilfsvariable;                
    else
        w(7)=w(7)+1;
        Sa(w(7))=i-hilfsvariable;
    end;
end;

% bestimmen der 24 Stunden je Wochentag
w=zeros(7,1);

for i=1:length(So)
    for j=(So(i)-1)*24+1:So(i)*24
        w(1)=w(1)+1;
        Sonntag(w(1))=j;
    end;
end;
for i=1:length(Mo)
    for j=(Mo(i)-1)*24+1:Mo(i)*24
        w(2)=w(2)+1;
        Montag(w(2))=j;
    end;
end;
for i=1:length(Di)
    for j=(Di(i)-1)*24+1:Di(i)*24
        w(3)=w(3)+1;
        Dienstag(w(3))=j;
    end;
end;
for i=1:length(Mi)
    for j=(Mi(i)-1)*24+1:Mi(i)*24
        w(4)=w(4)+1;
        Mittwoch(w(4))=j;
    end;
end;
for i=1:length(Do)
    for j=(Do(i)-1)*24+1:Do(i)*24
        w(5)=w(5)+1;
        Donnerstag(w(5))=j;
    end;
end;
for i=1:length(Fr)
    for j=(Fr(i)-1)*24+1:Fr(i)*24
        w(6)=w(6)+1;
        Freitag(w(6))=j;
    end;
end;
for i=1:length(Sa)
    for j=(Sa(i)-1)*24+1:Sa(i)*24
        w(7)=w(7)+1;
        Samstag(w(7))=j;
    end;
end;

% Bestimmen der Indizes für Jahreszeiten (Winter, Frühling, Sommer, Herbst)
% ---------------------------------------------------------
% hilfsvariable siehe Zeile 45
winter = [datenum(2002,1,1)-hilfsvariable:(datenum(2002,2,28)-hilfsvariable)*24, ...
    (datenum(2002,12,1)-hilfsvariable)*24:(datenum(2003,2,28)-hilfsvariable)*24, ...
    (datenum(2003,12,1)-hilfsvariable)*24:(datenum(2004,2,29)-hilfsvariable)*24, ...    
    (datenum(2004,12,1)-hilfsvariable)*24:(datenum(2005,2,28)-hilfsvariable)*24, ...
    (datenum(2005,12,1)-hilfsvariable)*24:(datenum(2006,2,28)-hilfsvariable)*24, ...
    (datenum(2006,12,1)-hilfsvariable)*24:(datenum(2007,2,28)-hilfsvariable)*24, ...
    (datenum(2007,12,1)-hilfsvariable)*24:(datenum(2008,2,29)-hilfsvariable)*24, ...
    (datenum(2008,12,1)-hilfsvariable)*24:(datenum(2008,12,31)-hilfsvariable)*24];
sommer = [(datenum(2002,6,1)-hilfsvariable)*24:(datenum(2002,8,31)-hilfsvariable)*24, ...
    (datenum(2003,6,1)-hilfsvariable)*24:(datenum(2003,8,31)-hilfsvariable)*24, ...    
    (datenum(2004,6,1)-hilfsvariable)*24:(datenum(2004,8,31)-hilfsvariable)*24, ...
    (datenum(2005,6,1)-hilfsvariable)*24:(datenum(2005,8,31)-hilfsvariable)*24, ...
    (datenum(2006,6,1)-hilfsvariable)*24:(datenum(2006,8,31)-hilfsvariable)*24, ...
    (datenum(2007,6,1)-hilfsvariable)*24:(datenum(2007,8,31)-hilfsvariable)*24, ...
    (datenum(2008,6,1)-hilfsvariable)*24:(datenum(2008,8,31)-hilfsvariable)*24];
fruehling = [(datenum(2002,3,1)-hilfsvariable)*24:(datenum(2002,5,31)-hilfsvariable)*24, ...
    (datenum(2003,3,1)-hilfsvariable)*24:(datenum(2003,5,31)-hilfsvariable)*24, ...    
    (datenum(2004,3,1)-hilfsvariable)*24:(datenum(2004,5,31)-hilfsvariable)*24, ...
    (datenum(2005,3,1)-hilfsvariable)*24:(datenum(2005,5,31)-hilfsvariable)*24, ...
    (datenum(2006,3,1)-hilfsvariable)*24:(datenum(2006,5,31)-hilfsvariable)*24, ...
    (datenum(2007,3,1)-hilfsvariable)*24:(datenum(2007,5,31)-hilfsvariable)*24, ...
    (datenum(2008,3,1)-hilfsvariable)*24:(datenum(2008,5,31)-hilfsvariable)*24];
herbst = [(datenum(2002,9,1)-hilfsvariable)*24:(datenum(2002,11,30)-hilfsvariable)*24, ...
    (datenum(2003,9,1)-hilfsvariable)*24:(datenum(2003,11,30)-hilfsvariable)*24, ...    
    (datenum(2004,9,1)-hilfsvariable)*24:(datenum(2004,11,30)-hilfsvariable)*24, ...
    (datenum(2005,9,1)-hilfsvariable)*24:(datenum(2005,11,30)-hilfsvariable)*24, ...
    (datenum(2006,9,1)-hilfsvariable)*24:(datenum(2006,11,30)-hilfsvariable)*24, ...
    (datenum(2007,9,1)-hilfsvariable)*24:(datenum(2007,11,30)-hilfsvariable)*24, ...
    (datenum(2008,9,1)-hilfsvariable)*24:(datenum(2008,11,30)-hilfsvariable)*24];

% ---------------------------------------------------------
% bestimmen der positiven und negativen Sprungvektoren
% in Abhängigkeit der Jahreszeiten:
% ---------------------------------------------------------

SchleifeLaufVariable=zeros(7,1);

SprungVektorPositivHerbstWinter=zeros(2,1);
SprungVektorPositivFruehlingSommer=zeros(2,1);
SprungVektorPositiv=zeros(2,1);
SprungVektorNegativHerbstWinter=zeros(2,1);
SprungVektorNegativFruehlingSommer=zeros(2,1);
SprungVektorNegativ=zeros(2,1);

Laenge_StrompreisVektor = length (StrompreisLog);

EsGibtSpruenge=1;
AnzahlSchleifenDurchlaeufe=0;


while EsGibtSpruenge && AnzahlSchleifenDurchlaeufe<40
    
    EsGibtSpruenge=0;
    MittelwertStrompreisLog=mean(StrompreisLog);

   %%%%%%%%%% 
   %%%%%%%%%% 
   %%%%%%%%%%
   %%%%%%%%%%
    
    Sprungplus = 2 * std(StrompreisLog);
    Sprungminus = -2 * std(StrompreisLog);

for i=1:Laenge_StrompreisVektor
    % ----------------------------------------------------
    % Positive Sprünge der verschiedenen Jahreszeiten/Halbjahre
    if (StrompreisLog(i)>Sprungplus) && (ismember(i,winter(1,:))...
            || ismember(i,herbst(1,:)))
        SchleifeLaufVariable(1)=SchleifeLaufVariable(1)+1;
        SprungVektorPositivHerbstWinter(1,SchleifeLaufVariable(1))=StrompreisLog(i);
        SprungVektorPositivHerbstWinter(2,SchleifeLaufVariable(1))=i;
        EsGibtSpruenge=1;
    end;
   if (StrompreisLog(i)>Sprungplus) && (ismember(i,fruehling(1,:))...
           || ismember(i,sommer(1,:)))
        SchleifeLaufVariable(2)=SchleifeLaufVariable(2)+1;
        SprungVektorPositivFruehlingSommer(1,SchleifeLaufVariable(2))=StrompreisLog(i);
        SprungVektorPositivFruehlingSommer(2,SchleifeLaufVariable(2))=i;
        EsGibtSpruenge=1;
    end;
    % alle positiven Sprünge
    if (StrompreisLog(i)>Sprungplus) && ... 
        (ismember(i,fruehling(1,:)) || ismember(i,sommer(1,:))...
        || ismember(i,herbst(1,:)) || ismember(i,winter(1,:)))
        SchleifeLaufVariable(3)=SchleifeLaufVariable(3)+1;
        SprungVektorPositiv(1,SchleifeLaufVariable(3))=StrompreisLog(i);
        SprungVektorPositiv(2,SchleifeLaufVariable(3))=i;
        StrompreisLog(i)=MittelwertStrompreisLog;
        EsGibtSpruenge=1;
    end;

    % ----------------------------------------------------
    % Negative Sprünge der verschiedenen Jahreszeiten/Halbjahre
    if (StrompreisLog(i)<Sprungminus) && (ismember(i,winter(1,:))...
            || ismember(i,herbst))
        SchleifeLaufVariable(4)=SchleifeLaufVariable(4)+1;
        SprungVektorNegativHerbstWinter(1,SchleifeLaufVariable(4))=StrompreisLog(i);
        SprungVektorNegativHerbstWinter(2,SchleifeLaufVariable(4))=i;
        EsGibtSpruenge=1;
    end;
   if (StrompreisLog(i)<Sprungminus) && (ismember(i,fruehling(1,:))...
           || ismember(i,sommer))
        SchleifeLaufVariable(5)=SchleifeLaufVariable(5)+1;
        SprungVektorNegativFruehlingSommer(1,SchleifeLaufVariable(5))=StrompreisLog(i);
        SprungVektorNegativFruehlingSommer(2,SchleifeLaufVariable(5))=i;
        EsGibtSpruenge=1;
    end;
    % alle negativen Sprünge
    if (StrompreisLog(i)<Sprungminus) && ... 
        (ismember(i,fruehling(1,:)) || ismember(i,sommer(1,:))...
        || ismember(i,herbst(1,:)) || ismember(i,winter(1,:)))
        SchleifeLaufVariable(6)=SchleifeLaufVariable(6)+1;
        SprungVektorNegativ(1,SchleifeLaufVariable(6))=StrompreisLog(i);
        SprungVektorNegativ(2,SchleifeLaufVariable(6))=i;
        StrompreisLog(i)=MittelwertStrompreisLog;        
        EsGibtSpruenge=1;
    end;
end;
AnzahlSchleifenDurchlaeufe=AnzahlSchleifenDurchlaeufe+1;
end;

% ---------------------------------------------------------
% Bestimmen der einzelnen Wahrscheinlichkeiten 
% für den Switching Regime:
% ---------------------------------------------------------

% 2002-2007, Anzahl Tage: 5*365+366 = 2191
% 2002-2007, Anzahl Stunden: 2191 * 24 = 52584
% 2002-2007, Anzahl Wochentage:  52584/7 = 7512, d.h. von 2002-2007 gibt
                               % es z.B. 7512 Samstage bzw. 7512 Sonntage

% Bestimmen der Indizes abhängig von Jahreszeit, Wochentag und dem 
% positiven bzw. negativen Sprungvektor.
% --------------------
% positive Sprünge am Samstag und Sonntag, ganzes Jahr:
SchnittmengePosSaSo=intersect(SprungVektorPositiv(2,:),...
            [Samstag, Sonntag]); 
% positive Sprünge an Montag bis Freitag, Herbst und Winter:
SchnittmengePosHerWinMoFr=intersect(SprungVektorPositivHerbstWinter(2,:),...
            [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]);        
% positive Sprünge an Montag bis Freitag, Frühling und Sommer:
SchnittmengePosFruSomMoFr=intersect(SprungVektorPositivFruehlingSommer(2,:),...
            [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]);
        
% negative Sprünge am Samstag und Sonntag, ganzes Jahr:
SchnittmengeNegSaSo=intersect(SprungVektorNegativ(2,:),...
            [Samstag, Sonntag]);
% negative Sprünge an Montag bis Freitag, Herbst und Winter:
SchnittmengeNegHerWinMoFr=intersect(SprungVektorNegativHerbstWinter(2,:),...
            [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]);        
% negative Sprünge an Montag bis Freitag, Frühling und Sommer:
SchnittmengeNegFruSomMoFr=intersect(SprungVektorNegativFruehlingSommer(2,:),...
            [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]);      

% ---------------------------------------------------------
% Anzahl der Sprünge abhängig vom Regime:
% --------------------
% POSITIVE Sprünge:
PositivP12=zeros(3,1);
PositivP21=zeros(3,1);
PositivP22=zeros(3,1);
iP=zeros(3,1);
PositivP21Stelle=zeros(1,1);
PositivP22Stelle=zeros(1,1);
PositivP12Stelle=zeros(1,1);

% Anzahl positiver Sprünge aufgeteilt auf die Regime
SprungVektorPositivSortiert=sort(SprungVektorPositiv(2,:));
iP(3)=1;
PositivP12Stelle(iP(3))= SprungVektorPositivSortiert(iP(3));
for i=1:length(SprungVektorPositivSortiert)-1
    if (SprungVektorPositivSortiert(i) - SprungVektorPositivSortiert(i+1)<-1)
        iP(1)=iP(1)+1; % Anzahl der "Sprünge", die aus Sprungregime ins Basis zurückkehren.       
        PositivP21Stelle(iP(1))=SprungVektorPositivSortiert(i);
    elseif SprungVektorPositivSortiert(i) - SprungVektorPositivSortiert(i+1)==-1
        iP(2)=iP(2)+1; % Anzahl der "Sprünge", die im Sprungregime verbleiben.        
        PositivP22Stelle(iP(2))=SprungVektorPositivSortiert(i);
    end;
end;
for i=2:length(SprungVektorPositivSortiert)
    if SprungVektorPositivSortiert(i)- SprungVektorPositivSortiert(i-1)>1
        iP(3)=iP(3)+1; % Anzahl der Sprünge, die aus dem Basisregime ins Sprungregime führen. 
        PositivP12Stelle(iP(3))=SprungVektorPositivSortiert(i);
    end;
end;
iP(1)=iP(1)+1;
PositivP21Stelle(iP(1))=SprungVektorPositivSortiert(i);

% Samstag, Sonntag, ganzes Jahr (Zeile 1 in PositivP12, etc.)
PositivP12(1,1)=length(intersect(PositivP12Stelle,SchnittmengePosSaSo));
PositivP22(1,1)=length(intersect(PositivP22Stelle,SchnittmengePosSaSo));
PositivP21(1,1)=length(intersect(PositivP21Stelle,SchnittmengePosSaSo));

% Montag bis Freitag, Herbst+Winter (Zeile 2 in PositivP12, etc.)
PositivP12(2,1)=length(intersect(PositivP12Stelle,SchnittmengePosHerWinMoFr));
PositivP22(2,1)=length(intersect(PositivP22Stelle,SchnittmengePosHerWinMoFr));
PositivP21(2,1)=length(intersect(PositivP21Stelle,SchnittmengePosHerWinMoFr));

% Montag bis Freitag, Frühling+Sommer (Zeile 3 in PositivP12, etc.)
PositivP12(3,1)=length(intersect(PositivP12Stelle,SchnittmengePosFruSomMoFr));
PositivP22(3,1)=length(intersect(PositivP22Stelle,SchnittmengePosFruSomMoFr));
PositivP21(3,1)=length(intersect(PositivP21Stelle,SchnittmengePosFruSomMoFr));

% --------------------
% NEGATIVE Sprünge:
NegativP12=zeros(3,1);
NegativP21=zeros(3,1);
NegativP22=zeros(3,1);
iN=zeros(3,1);
NegativP21Stelle=zeros(1,1);
NegativP22Stelle=zeros(1,1);
NegativP12Stelle=zeros(1,1);

% Anzahl negativen Sprünge aufgeteilt auf die Regime
SprungVektorNegativSortiert=sort(SprungVektorNegativ(2,:));
iN(3)=1;
NegativP12Stelle(iN(3))= SprungVektorNegativSortiert(iN(3));
for i=1:length(SprungVektorNegativSortiert)-1
    if (SprungVektorNegativSortiert(i) - SprungVektorNegativSortiert(i+1)<-1)
        iN(1)=iN(1)+1; % Anzahl der "Sprünge", die aus Sprungregime ins Basis zurückkehren.       
        NegativP21Stelle(iN(1))=SprungVektorNegativSortiert(i);
    elseif SprungVektorNegativSortiert(i) - SprungVektorNegativSortiert(i+1)==-1
        iN(2)=iN(2)+1; % Anzahl der "Sprünge", die im Sprungregime verbleiben.        
        NegativP22Stelle(iN(2))=SprungVektorNegativSortiert(i);
    end;
end;
for i=2:length(SprungVektorNegativSortiert)
    if SprungVektorNegativSortiert(i)- SprungVektorNegativSortiert(i-1)>1
        iN(3)=iN(3)+1; % Anzahl der Sprünge, die aus dem Basisregime ins Sprungregime führen. 
        NegativP12Stelle(iN(3))=SprungVektorNegativSortiert(i);
    end;
end;
iN(1)=iN(1)+1;
NegativP21Stelle(iN(1))=SprungVektorNegativSortiert(i);

% Samstag, Sonntag, ganzes Jahr (Zeile 1 in PositivP12, etc.)
NegativP12(1,1)=length(intersect(NegativP12Stelle,SchnittmengeNegSaSo));
NegativP22(1,1)=length(intersect(NegativP22Stelle,SchnittmengeNegSaSo));
NegativP21(1,1)=length(intersect(NegativP21Stelle,SchnittmengeNegSaSo));

% Montag bis Freitag, Herbst+Winter (Zeile 2 in PositivP12, etc.)
NegativP12(2,1)=length(intersect(NegativP12Stelle,SchnittmengeNegHerWinMoFr));
NegativP22(2,1)=length(intersect(NegativP22Stelle,SchnittmengeNegHerWinMoFr));
NegativP21(2,1)=length(intersect(NegativP21Stelle,SchnittmengeNegHerWinMoFr));

% Montag bis Freitag, Frühling+Sommer (Zeile 3 in PositivP12, etc.)
NegativP12(3,1)=length(intersect(NegativP12Stelle,SchnittmengeNegFruSomMoFr));
NegativP22(3,1)=length(intersect(NegativP22Stelle,SchnittmengeNegFruSomMoFr));
NegativP21(3,1)=length(intersect(NegativP21Stelle,SchnittmengeNegFruSomMoFr));


% ---------------------------------------------------------
% Berechnen der Wahrscheinlichkeitsmatrix in Abhängigkeit von
% Jahreszeiten und Wochentagen:
% --------------------
% positive Sprünge, Samstag/Sonntag:
k=1; 
% W'keit für den Übergang in das Sprungregime:
PositivT(k,1,2)= PositivP12(k)/...
    (length(intersect([winter, fruehling, sommer, herbst],...
                      [Samstag, Sonntag]))...
     - (PositivP12(k)+PositivP22(k)));
% W'keit das der Prozess im normalen Regime verbleibt:
PositivT(k,1,1)= 1 - PositivT(k,1,2); 
% W'keit, dass der Prozess aus einem Sprungzustand in das normale Regime
% übergeht:
if PositivP21(k)==0 && PositivP22(k)==0
    PositivT(k,2,1)=0; 
    PositivT(k,2,2)=0;
else
    PositivT(k,2,1)= PositivP21(k)/(PositivP21(k)+PositivP22(k));
    % W'keit, dass der Prozess im Sprungzustand verbleibt:
    PositivT(k,2,2)= PositivP22(k)/(PositivP21(k)+PositivP22(k));
end;
% --------------------
% positive Sprünge, Herbst&Winter, Montag-Freitag:
k=2; 
% W'keit für den Übergang in das Sprungregime:
PositivT(k,1,2)= PositivP12(k)/...
    (length(intersect([winter, herbst],...
                      [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]))...
     - (PositivP12(k)+PositivP22(k)));
% W'keit das der Prozess im normalen Regime verbleibt:
PositivT(k,1,1)= 1 - PositivT(k,1,2); 
% W'keit, dass der Prozess aus einem Sprungzustand in das normale Regime
% übergeht:
if PositivP21(k)==0 && PositivP22(k)==0
    PositivT(k,2,1)=0; 
    PositivT(k,2,2)=0;
else
    PositivT(k,2,1)= PositivP21(k)/(PositivP21(k)+PositivP22(k));
    % W'keit, dass der Prozess im Sprungzustand verbleibt:
    PositivT(k,2,2)= PositivP22(k)/(PositivP21(k)+PositivP22(k));
end;
% --------------------
% positive Sprünge, Frühling&Sommer, Montag-Freitag:
k=3; 
% W'keit für den Übergang in das Sprungregime:
PositivT(k,1,2)= PositivP12(k)/...
    (length(intersect([fruehling, sommer],...
                      [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]))...
     - (PositivP12(k)+PositivP22(k)));
% W'keit das der Prozess im normalen Regime verbleibt:
PositivT(k,1,1)= 1 - PositivT(k,1,2); 
% W'keit, dass der Prozess aus einem Sprungzustand in das normale Regime
% übergeht:
if PositivP21(k)==0 && PositivP22(k)==0
    PositivT(k,2,1)=0; 
    PositivT(k,2,2)=0;
else
    PositivT(k,2,1)= PositivP21(k)/(PositivP21(k)+PositivP22(k));
    % W'keit, dass der Prozess im Sprungzustand verbleibt:
    PositivT(k,2,2)= PositivP22(k)/(PositivP21(k)+PositivP22(k));
end;

% --------------------
% negative Sprünge, Samstag/Sonntag:
k=1; 
% W'keit für den Übergang in das Sprungregime:
NegativT(k,1,2)= NegativP12(k)/...
    (length(intersect([winter, fruehling, sommer, herbst],...
                      [Samstag, Sonntag]))...
     - (NegativP12(k)+ NegativP22(k)));
% W'keit das der Prozess im normalen Regime verbleibt:
NegativT(k,1,1)= 1 - NegativT(k,1,2); 
% W'keit, dass der Prozess aus einem Sprungzustand in das normale Regime
% übergeht:
if NegativP21(k)==0 && NegativP22(k)==0
    NegativT(k,2,1)=0; 
    NegativT(k,2,2)=0;
else
    NegativT(k,2,1)= NegativP21(k)/(NegativP21(k)+NegativP22(k));
    % W'keit, dass der Prozess im Sprungzustand verbleibt:
    NegativT(k,2,2)= NegativP22(k)/(NegativP21(k)+NegativP22(k));
end;
% --------------------
% negative Sprünge, Herbst&Winter, Montag-Freitag:
k=2; 
% W'keit für den Übergang in das Sprungregime:
NegativT(k,1,2)= NegativP12(k)/...
    (length(intersect([winter, herbst],...
                      [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]))...
     - (NegativP12(k)+NegativP22(k)));
% W'keit das der Prozess im normalen Regime verbleibt:
NegativT(k,1,1)= 1 - NegativT(k,1,2); 
% W'keit, dass der Prozess aus einem Sprungzustand in das normale Regime
% übergeht:
if NegativP21(k)==0 && NegativP22(k)==0
    NegativT(k,2,1)=0; 
    NegativT(k,2,2)=0;
else
    NegativT(k,2,1)= NegativP21(k)/(NegativP21(k)+NegativP22(k));
    % W'keit, dass der Prozess im Sprungzustand verbleibt:
    NegativT(k,2,2)= NegativP22(k)/(NegativP21(k)+NegativP22(k));
end;
% --------------------
% negative Sprünge, Frühling&Sommer, Montag-Freitag:
k=3; 
% W'keit für den Übergang in das Sprungregime:
NegativT(k,1,2)= NegativP12(k)/...
    (length(intersect([fruehling, sommer],...
                      [Montag, Dienstag, Mittwoch, Donnerstag, Freitag]))...
     - (NegativP12(k)+NegativP22(k)));
% W'keit das der Prozess im normalen Regime verbleibt:
NegativT(k,1,1)= 1 - NegativT(k,1,2); 
% W'keit, dass der Prozess aus einem Sprungzustand in das normale Regime
% übergeht:
if NegativP21(k)==0 && NegativP22(k)==0
    NegativT(k,2,1)=0; 
    NegativT(k,2,2)=0;
else
    NegativT(k,2,1)= NegativP21(k)/(NegativP21(k)+NegativP22(k));
    % W'keit, dass der Prozess im Sprungzustand verbleibt:
    NegativT(k,2,2)= NegativP22(k)/(NegativP21(k)+NegativP22(k));
end;