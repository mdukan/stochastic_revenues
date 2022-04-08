%gives polynomials of the different shareholder values for Mer R001
function [Mer_p1,Mer_p2,Mer_p3,Mer_p4,Mer_p5,Mer_p6,Mer_p7,Mer_p8,Mer_p9,Mer_p10,Mer_p11,Mer_p12,Mer_p13]= MerpolyfitR001(DL,Mer_Sv1,Mer_Sv2,Mer_Sv3,Mer_Sv4,...
    Mer_Sv5,Mer_Sv6,Mer_Sv7,Mer_Sv8,Mer_Sv9,Mer_Sv10,Mer_Sv11,Mer_Sv12,Mer_Sv13)

Mer_p1 = polyfit(DL,Mer_Sv1,3);
Mer_p2 = polyfit(DL,Mer_Sv2,3);
Mer_p3 = polyfit(DL,Mer_Sv3,3);
Mer_p4 = polyfit(DL,Mer_Sv4,3);
Mer_p5 = polyfit(DL,Mer_Sv5,3);
Mer_p6 = polyfit(DL,Mer_Sv6,3);
Mer_p7 = polyfit(DL,Mer_Sv7,3);
Mer_p8 = polyfit(DL,Mer_Sv8,3);
Mer_p9 = polyfit(DL,Mer_Sv9,3);
Mer_p10 = polyfit(DL,Mer_Sv10,3);
Mer_p11 = polyfit(DL,Mer_Sv11,3);
Mer_p12 = polyfit(DL,Mer_Sv12,3);
Mer_p13 = polyfit(DL,Mer_Sv13,3);

end