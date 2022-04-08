function [k_cfd17,r_cfd17,points_cfd17,y_cfd17,max_y_cfd17,xi_cfd17,peak_CfD17] = CFDmp17 (CfD_p17, x_range)

k_cfd17 = polyder(CfD_p17); % find derivative of above polynomial
r_cfd17 = roots(k_cfd17); % find roots of polynomHHial created from derivative above
r_cfd17 = r_cfd17(r_cfd17>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd17)
  r_cfd17 = r_cfd17(r_cfd17<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd17)
  points_cfd17 = zeros(1,2+length(r_cfd17)); % pre-allocate
  points_cfd17(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd17)
      points_cfd17(2+ii) = r_cfd17(ii);
  end
else
  points_cfd17 = x_range;
end
y_cfd17 = polyval(CfD_p17,points_cfd17);
[max_y_cfd17,xi_cfd17] = max(y_cfd17);
peak_CfD17 = [points_cfd17(xi_cfd17),max_y_cfd17]; % x & y coordinates of peak

end

