function [k_cfd8,r_cfd8,points_cfd8,y_cfd8,max_y_cfd8,xi_cfd8,peak_CfD8] = CFDmp8 (CfD_p8, x_range)

k_cfd8 = polyder(CfD_p8); % find derivative of above polynomial
r_cfd8 = roots(k_cfd8); % find roots of polynomHHial created from derivative above
r_cfd8 = r_cfd8(r_cfd8>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd8)
  r_cfd8 = r_cfd8(r_cfd8<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd8)
  points_cfd8 = zeros(1,2+length(r_cfd8)); % pre-allocate
  points_cfd8(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd8)
      points_cfd8(2+ii) = r_cfd8(ii);
  end
else
  points_cfd8 = x_range;
end
y_cfd8 = polyval(CfD_p8,points_cfd8);
[max_y_cfd8,xi_cfd8] = max(y_cfd8);
peak_CfD8 = [points_cfd8(xi_cfd8),max_y_cfd8]; % x & y coordinates of peak

end

