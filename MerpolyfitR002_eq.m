%gives polynomials of the different shareholder values for Mer R002
function [Mer_p1,Mer_p2]= MerpolyfitR002_eq(DL,Mer_Sv1,Mer_Sv2)

Mer_p1 = polyfit(DL,Mer_Sv1,3);
Mer_p2 = polyfit(DL,Mer_Sv2,3);

end