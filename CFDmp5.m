function [k_cfd5,r_cfd5,points_cfd5,y_cfd5,max_y_cfd5,xi_cfd5,peak_CfD5] = CFDmp5 (CfD_p5, x_range)

k_cfd5 = polyder(CfD_p5); % find derivative of above polynomial
r_cfd5 = roots(k_cfd5); % find roots of polynomHHial created from derivative above
r_cfd5 = r_cfd5(r_cfd5>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd5)
  r_cfd5 = r_cfd5(r_cfd5<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd5)
  points_cfd5 = zeros(1,2+length(r_cfd5)); % pre-allocate
  points_cfd5(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd5)
      points_cfd5(2+ii) = r_cfd5(ii);
  end
else
  points_cfd5 = x_range;
end
y_cfd5 = polyval(CfD_p5,points_cfd5);
[max_y_cfd5,xi_cfd5] = max(y_cfd5);
peak_CfD5 = [points_cfd5(xi_cfd5),max_y_cfd5]; % x & y coordinates of peak

end

