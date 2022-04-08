function [k_cfd14,r_cfd14,points_cfd14,y_cfd14,max_y_cfd14,xi_cfd14,peak_CfD14] = CFDmp14 (CfD_p14, x_range)

k_cfd14 = polyder(CfD_p14); % find derivative of above polynomial
r_cfd14 = roots(k_cfd14); % find roots of polynomHHial created from derivative above
r_cfd14 = r_cfd14(r_cfd14>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd14)
  r_cfd14 = r_cfd14(r_cfd14<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd14)
  points_cfd14 = zeros(1,2+length(r_cfd14)); % pre-allocate
  points_cfd14(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd14)
      points_cfd14(2+ii) = r_cfd14(ii);
  end
else
  points_cfd14 = x_range;
end
y_cfd14 = polyval(CfD_p14,points_cfd14);
[max_y_cfd14,xi_cfd14] = max(y_cfd14);
peak_CfD14 = [points_cfd14(xi_cfd14),max_y_cfd14]; % x & y coordinates of peak

end

