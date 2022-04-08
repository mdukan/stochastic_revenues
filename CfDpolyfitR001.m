
%gives polynomials of the different shareholder values for CfD R001
function [CfD_p1,CfD_p2,CfD_p3,CfD_p4,CfD_p5,CfD_p6,CfD_p7,CfD_p8,CfD_p9,CfD_p10,CfD_p11,CfD_p12,CfD_p13]= CfDpolyfitR001(DL,CfD_Sv1,CfD_Sv2,CfD_Sv3,CfD_Sv4,...
    CfD_Sv5,CfD_Sv6,CfD_Sv7,CfD_Sv8,CfD_Sv9,CfD_Sv10,CfD_Sv11,CfD_Sv12,CfD_Sv13)

CfD_p1 = polyfit(DL,CfD_Sv1,3);
CfD_p2 = polyfit(DL,CfD_Sv2,3);
CfD_p3 = polyfit(DL,CfD_Sv3,3);
CfD_p4 = polyfit(DL,CfD_Sv4,3);
CfD_p5 = polyfit(DL,CfD_Sv5,3);
CfD_p6 = polyfit(DL,CfD_Sv6,3);
CfD_p7 = polyfit(DL,CfD_Sv7,3);
CfD_p8 = polyfit(DL,CfD_Sv8,3);
CfD_p9 = polyfit(DL,CfD_Sv9,3);
CfD_p10 = polyfit(DL,CfD_Sv10,3);
CfD_p11 = polyfit(DL,CfD_Sv11,3);
CfD_p12 = polyfit(DL,CfD_Sv12,3);
CfD_p13 = polyfit(DL,CfD_Sv13,3);

end