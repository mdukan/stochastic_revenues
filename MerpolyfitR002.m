%gives polynomials of the different shareholder values for Mer R002
function [Mer_p14,Mer_p15,Mer_p16,Mer_p17,Mer_p18,Mer_p19,Mer_p20,Mer_p21,Mer_p22,Mer_p23,Mer_p24]= MerpolyfitR002(DL,Mer_Sv14,Mer_Sv15,Mer_Sv16,Mer_Sv17,...
    Mer_Sv18,Mer_Sv19,Mer_Sv20,Mer_Sv21,Mer_Sv22,Mer_Sv23,Mer_Sv24)

Mer_p14 = polyfit(DL,Mer_Sv14,3);
Mer_p15 = polyfit(DL,Mer_Sv15,3);
Mer_p16 = polyfit(DL,Mer_Sv16,3);
Mer_p17 = polyfit(DL,Mer_Sv17,3);
Mer_p18 = polyfit(DL,Mer_Sv18,3);
Mer_p19 = polyfit(DL,Mer_Sv19,3);
Mer_p20 = polyfit(DL,Mer_Sv20,3);
Mer_p21 = polyfit(DL,Mer_Sv21,3);
Mer_p22 = polyfit(DL,Mer_Sv22,3);
Mer_p23 = polyfit(DL,Mer_Sv23,3);
Mer_p24 = polyfit(DL,Mer_Sv24,3);

end