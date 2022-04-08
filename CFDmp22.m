function [k_cfd22,r_cfd22,points_cfd22,y_cfd22,max_y_cfd22,xi_cfd22,peak_CfD22] = CFDmp22 (CfD_p22, x_range)

k_cfd22 = polyder(CfD_p22); % find derivative of above polynomial
r_cfd22 = roots(k_cfd22); % find roots of polynomHHial created from derivative above
r_cfd22 = r_cfd22(r_cfd22>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd22)
  r_cfd22 = r_cfd22(r_cfd22<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd22)
  points_cfd22 = zeros(1,2+length(r_cfd22)); % pre-allocate
  points_cfd22(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd22)
      points_cfd22(2+ii) = r_cfd22(ii);
  end
else
  points_cfd22 = x_range;
end
y_cfd22 = polyval(CfD_p22,points_cfd22);
[max_y_cfd22,xi_cfd22] = max(y_cfd22);
peak_CfD22 = [points_cfd22(xi_cfd22),max_y_cfd22]; % x & y coordinates of peak

end

