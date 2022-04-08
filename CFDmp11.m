function [k_cfd11,r_cfd11,points_cfd11,y_cfd11,max_y_cfd11,xi_cfd11,peak_CfD11] = CFDmp11 (CfD_p11, x_range)

k_cfd11 = polyder(CfD_p11); % find derivative of above polynomial
r_cfd11 = roots(k_cfd11); % find roots of polynomHHial created from derivative above
r_cfd11 = r_cfd11(r_cfd11>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd11)
  r_cfd11 = r_cfd11(r_cfd11<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd11)
  points_cfd11 = zeros(1,2+length(r_cfd11)); % pre-allocate
  points_cfd11(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd11)
      points_cfd11(2+ii) = r_cfd11(ii);
  end
else
  points_cfd11 = x_range;
end
y_cfd11 = polyval(CfD_p11,points_cfd11);
[max_y_cfd11,xi_cfd11] = max(y_cfd11);
peak_CfD11 = [points_cfd11(xi_cfd11),max_y_cfd11]; % x & y coordinates of peak

end

