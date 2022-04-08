
%gives polynomials of the different shareholder values for CfD R002
function [CfD_p14,CfD_p15,CfD_p16,CfD_p17,CfD_p18,CfD_p19,CfD_p20,CfD_p21,CfD_p22,CfD_p23,CfD_p24]= CfDpolyfitR002(DL,CfD_Sv14,CfD_Sv15,CfD_Sv16,CfD_Sv17,...
    CfD_Sv18,CfD_Sv19,CfD_Sv20,CfD_Sv21,CfD_Sv22,CfD_Sv23,CfD_Sv24)

CfD_p14 = polyfit(DL,CfD_Sv14,3);
CfD_p15 = polyfit(DL,CfD_Sv15,3);
CfD_p16 = polyfit(DL,CfD_Sv16,3);
CfD_p17 = polyfit(DL,CfD_Sv17,3);
CfD_p18 = polyfit(DL,CfD_Sv18,3);
CfD_p19 = polyfit(DL,CfD_Sv19,3);
CfD_p20 = polyfit(DL,CfD_Sv20,3);
CfD_p21 = polyfit(DL,CfD_Sv21,3);
CfD_p22 = polyfit(DL,CfD_Sv22,3);
CfD_p23 = polyfit(DL,CfD_Sv23,3);
CfD_p24 = polyfit(DL,CfD_Sv24,3);

end