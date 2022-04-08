k=1;
i=1;

while i<length(Wind2011viertel)
        Wind2011(k) = mean(Wind2011viertel(i:(i+3)));
        k=k+1;
        i=i+4;
end;

Wind2011 = Wind2011';