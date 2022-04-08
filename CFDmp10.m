function [k_cfd10,r_cfd10,points_cfd10,y_cfd10,max_y_cfd10,xi_cfd10,peak_CfD10] = CFDmp10 (CfD_p10, x_range)

k_cfd10 = polyder(CfD_p10); % find derivative of above polynomial
r_cfd10 = roots(k_cfd10); % find roots of polynomHHial created from derivative above
r_cfd10 = r_cfd10(r_cfd10>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd10)
  r_cfd10 = r_cfd10(r_cfd10<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd10)
  points_cfd10 = zeros(1,2+length(r_cfd10)); % pre-allocate
  points_cfd10(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd10)
      points_cfd10(2+ii) = r_cfd10(ii);
  end
else
  points_cfd10 = x_range;
end
y_cfd10 = polyval(CfD_p10,points_cfd10);
[max_y_cfd10,xi_cfd10] = max(y_cfd10);
peak_CfD10 = [points_cfd10(xi_cfd10),max_y_cfd10]; % x & y coordinates of peak

end

