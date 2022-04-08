function [k_cfd4,r_cfd4,points_cfd4,y_cfd4,max_y_cfd4,xi_cfd4,peak_CfD4] = CFDmp4 (CfD_p4, x_range)

k_cfd4 = polyder(CfD_p4); % find derivative of above polynomial
r_cfd4 = roots(k_cfd4); % find roots of polynomHHial created from derivative above
r_cfd4 = r_cfd4(r_cfd4>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd4)
  r_cfd4 = r_cfd4(r_cfd4<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd4)
  points_cfd4 = zeros(1,2+length(r_cfd4)); % pre-allocate
  points_cfd4(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd4)
      points_cfd4(2+ii) = r_cfd4(ii);
  end
else
  points_cfd4 = x_range;
end
y_cfd4 = polyval(CfD_p4,points_cfd4);
[max_y_cfd4,xi_cfd4] = max(y_cfd4);
peak_CfD4 = [points_cfd4(xi_cfd4),max_y_cfd4]; % x & y coordinates of peak

end

