%trigonometric function for seasonal fitting



function y = trigoFit(beta,t)
y= beta(1)*cos(2*pi*t*beta(2) + beta(6)) + beta(3)*sin(4*pi*t * beta(4)+ beta(7)) + beta(5) ;
%y= beta(1)*cos(2*pi*t*beta(2)+ beta(3))  + beta(4) ;
y=y';
end