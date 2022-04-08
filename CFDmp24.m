function [k_cfd24,r_cfd24,points_cfd24,y_cfd24,max_y_cfd24,xi_cfd24,peak_CfD24] = CFDmp24 (CfD_p24, x_range)

k_cfd24 = polyder(CfD_p24); % find derivative of above polynomial
r_cfd24 = roots(k_cfd24); % find roots of polynomHHial created from derivative above
r_cfd24 = r_cfd24(r_cfd24>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd24)
  r_cfd24 = r_cfd24(r_cfd24<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd24)
  points_cfd24 = zeros(1,2+length(r_cfd24)); % pre-allocate
  points_cfd24(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd24)
      points_cfd24(2+ii) = r_cfd24(ii);
  end
else
  points_cfd24 = x_range;
end
y_cfd24 = polyval(CfD_p24,points_cfd24);
[max_y_cfd24,xi_cfd24] = max(y_cfd24);
peak_CfD24 = [points_cfd24(xi_cfd24),max_y_cfd24]; % x & y coordinates of peak

end

