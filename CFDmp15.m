function [k_cfd15,r_cfd15,points_cfd15,y_cfd15,max_y_cfd15,xi_cfd15,peak_CfD15] = CFDmp15 (CfD_p15, x_range)

k_cfd15 = polyder(CfD_p15); % find derivative of above polynomial
r_cfd15 = roots(k_cfd15); % find roots of polynomHHial created from derivative above
r_cfd15 = r_cfd15(r_cfd15>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd15)
  r_cfd15 = r_cfd15(r_cfd15<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd15)
  points_cfd15 = zeros(1,2+length(r_cfd15)); % pre-allocate
  points_cfd15(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd15)
      points_cfd15(2+ii) = r_cfd15(ii);
  end
else
  points_cfd15 = x_range;
end
y_cfd15 = polyval(CfD_p15,points_cfd15);
[max_y_cfd15,xi_cfd15] = max(y_cfd15);
peak_CfD15 = [points_cfd15(xi_cfd15),max_y_cfd15]; % x & y coordinates of peak

end

