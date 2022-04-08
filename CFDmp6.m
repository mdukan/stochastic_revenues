function [k_cfd6,r_cfd6,points_cfd6,y_cfd6,max_y_cfd6,xi_cfd6,peak_CfD6] = CFDmp6 (CfD_p6, x_range)

k_cfd6 = polyder(CfD_p6); % find derivative of above polynomial
r_cfd6 = roots(k_cfd6); % find roots of polynomHHial created from derivative above
r_cfd6 = r_cfd6(r_cfd6>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd6)
  r_cfd6 = r_cfd6(r_cfd6<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd6)
  points_cfd6 = zeros(1,2+length(r_cfd6)); % pre-allocate
  points_cfd6(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd6)
      points_cfd6(2+ii) = r_cfd6(ii);
  end
else
  points_cfd6 = x_range;
end
y_cfd6 = polyval(CfD_p6,points_cfd6);
[max_y_cfd6,xi_cfd6] = max(y_cfd6);
peak_CfD6 = [points_cfd6(xi_cfd6),max_y_cfd6]; % x & y coordinates of peak

end

