%logit 

function y=logit(x)

z=x./(1-x);
y=log(z);

end