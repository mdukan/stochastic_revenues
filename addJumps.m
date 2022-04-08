function SimSeries = addJumps(y,PosJumps,NegJumps,delta)
    SimHours = length(y);
    SimSeries = zeros(SimHours,1);
    %Addition of positive and negative jumps:
    phatPos = mle (PosJumps(1,:));
    phatNeg = mle (NegJumps(1,:));
    for i=1 : SimHours
        if delta(i)>=0
            SimSeries(i)= y(i) ...
                    + delta(i) * normrnd(phatPos(1), phatPos(2)); % normalverteiltes epsilon (t+1)
        else
            SimSeries(i)= y(i) ...
                    - delta(i) * normrnd(phatNeg(1), phatNeg(2)); % normalverteiltes epsilon (t+1)
        end;
    end;
end