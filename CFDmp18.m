function [k_cfd18,r_cfd18,points_cfd18,y_cfd18,max_y_cfd18,xi_cfd18,peak_CfD18] = CFDmp18 (CfD_p18, x_range)

k_cfd18 = polyder(CfD_p18); % find derivative of above polynomial
r_cfd18 = roots(k_cfd18); % find roots of polynomHHial created from derivative above
r_cfd18 = r_cfd18(r_cfd18>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd18)
  r_cfd18 = r_cfd18(r_cfd18<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd18)
  points_cfd18 = zeros(1,2+length(r_cfd18)); % pre-allocate
  points_cfd18(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd18)
      points_cfd18(2+ii) = r_cfd18(ii);
  end
else
  points_cfd18 = x_range;
end
y_cfd18 = polyval(CfD_p18,points_cfd18);
[max_y_cfd18,xi_cfd18] = max(y_cfd18);
peak_CfD18 = [points_cfd18(xi_cfd18),max_y_cfd18]; % x & y coordinates of peak

end

