function [k_cfd1,r_cfd1,points_cfd1,y_cfd1,max_y_cfd1,xi_cfd1,peak_CfD1] = CFDmp (CfD_p, x_range)

k_cfd1 = polyder(CfD_p); % find derivative of above polynomial
r_cfd1 = roots(k_cfd1); % find roots of polynomHHial created from derivative above
r_cfd1 = r_cfd1(r_cfd1>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd1)
  r_cfd1 = r_cfd1(r_cfd1<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd1)
  points_cfd1 = zeros(1,2+length(r_cfd1)); % pre-allocate
  points_cfd1(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd1)
      points_cfd1(2+ii) = r_cfd1(ii);
  end
else
  points_cfd1 = x_range;
end
y_cfd1 = polyval(CfD_p,points_cfd1);
[max_y_cfd1,xi_cfd1] = max(y_cfd1);
peak_CfD1 = [points_cfd1(xi_cfd1),max_y_cfd1]; % x & y coordinates of peak

end

