function [k_cfd21,r_cfd21,points_cfd21,y_cfd21,max_y_cfd21,xi_cfd21,peak_CfD21] = CFDmp21 (CfD_p21, x_range)

k_cfd21 = polyder(CfD_p21); % find derivative of above polynomial
r_cfd21 = roots(k_cfd21); % find roots of polynomHHial created from derivative above
r_cfd21 = r_cfd21(r_cfd21>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd21)
  r_cfd21 = r_cfd21(r_cfd21<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd21)
  points_cfd21 = zeros(1,2+length(r_cfd21)); % pre-allocate
  points_cfd21(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd21)
      points_cfd21(2+ii) = r_cfd21(ii);
  end
else
  points_cfd21 = x_range;
end
y_cfd21 = polyval(CfD_p21,points_cfd21);
[max_y_cfd21,xi_cfd21] = max(y_cfd21);
peak_CfD21 = [points_cfd21(xi_cfd21),max_y_cfd21]; % x & y coordinates of peak

end

