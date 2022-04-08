function [SimSeries,InnovationsGARCH] = GarchSim(p,q,DataSeries,SimYear,numberSim)

SimHours = 24*(datenum(SimYear,12,31)-datenum(SimYear-1,12,31));
SimSeries=zeros(SimHours,numberSim);

GARCH_p = p;
GARCH_q = q;
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
spec = garchset('P', GARCH_p, 'Q', GARCH_q);
% Specification of the GARCH-Process:
[CoeffGARCH,ErrorGarch,LLFGarch,InnovationsGARCH] = garchfit (spec,DataSeries);

alphaGARCH=CoeffGARCH.ARCH(:);
betaGARCH=CoeffGARCH.GARCH(:);
omegaGARCH=CoeffGARCH.K(:);
phat = mle(DataSeries);
MaximumGARCHpq=max(GARCH_p,GARCH_q);

for k=1:numberSim
    sigmaQuad=zeros(SimHours+MaximumGARCHpq,1);
    sigma=zeros(SimHours+MaximumGARCHpq,1);
    for i=1:MaximumGARCHpq
        sigmaQuad(i) = omegaGARCH;
    end;

    epsilonG=zeros(SimHours+MaximumGARCHpq,1);
    epsilon = zeros(SimHours,1);
    % first epsilon values generated as normald distributed values

    for i=1:MaximumGARCHpq
        epsilonG(i)=normrnd(phat(1), phat(2));
    end;
    % GARCH-formula:
    for i=1+MaximumGARCHpq : SimHours+MaximumGARCHpq
        for j=1:GARCH_p
            sigmaQuad(i) = sigmaQuad(i) + alphaGARCH(j) * (epsilonG(i-j))^2;
        end;
        for j=1:GARCH_q
            sigmaQuad(i) = sigmaQuad(i) + betaGARCH(j)* (sigmaQuad(i-j));
        end;
   
        sigmaQuad(i)=sigmaQuad(i) + omegaGARCH;
        sigma(i) = sqrt(sigmaQuad(i));
        epsilonG(i) = sigma(i)*normrnd(0,1);
    end;
    epsilon = epsilonG(MaximumGARCHpq+1:SimHours+MaximumGARCHpq);   
    SimSeries(:,k)=epsilon;
end;
end
