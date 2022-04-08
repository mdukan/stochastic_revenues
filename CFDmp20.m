function [k_cfd20,r_cfd20,points_cfd20,y_cfd20,max_y_cfd20,xi_cfd20,peak_CfD20] = CFDmp20 (CfD_p20, x_range)

k_cfd20 = polyder(CfD_p20); % find derivative of above polynomial
r_cfd20 = roots(k_cfd20); % find roots of polynomHHial created from derivative above
r_cfd20 = r_cfd20(r_cfd20>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd20)
  r_cfd20 = r_cfd20(r_cfd20<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd20)
  points_cfd20 = zeros(1,2+length(r_cfd20)); % pre-allocate
  points_cfd20(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd20)
      points_cfd20(2+ii) = r_cfd20(ii);
  end
else
  points_cfd20 = x_range;
end
y_cfd20 = polyval(CfD_p20,points_cfd20);
[max_y_cfd20,xi_cfd20] = max(y_cfd20);
peak_CfD20 = [points_cfd20(xi_cfd20),max_y_cfd20]; % x & y coordinates of peak

end

