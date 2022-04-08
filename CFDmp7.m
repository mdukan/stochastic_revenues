function [k_cfd7,r_cfd7,points_cfd7,y_cfd7,max_y_cfd7,xi_cfd7,peak_CfD7] = CFDmp7 (CfD_p7, x_range)

k_cfd7 = polyder(CfD_p7); % find derivative of above polynomial
r_cfd7 = roots(k_cfd7); % find roots of polynomHHial created from derivative above
r_cfd7 = r_cfd7(r_cfd7>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd7)
  r_cfd7 = r_cfd7(r_cfd7<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd7)
  points_cfd7 = zeros(1,2+length(r_cfd7)); % pre-allocate
  points_cfd7(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd7)
      points_cfd7(2+ii) = r_cfd7(ii);
  end
else
  points_cfd7 = x_range;
end
y_cfd7 = polyval(CfD_p7,points_cfd7);
[max_y_cfd7,xi_cfd7] = max(y_cfd7);
peak_CfD7 = [points_cfd7(xi_cfd7),max_y_cfd7]; % x & y coordinates of peak

end

