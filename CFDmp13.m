function [k_cfd13,r_cfd13,points_cfd13,y_cfd13,max_y_cfd13,xi_cfd13,peak_CfD13] = CFDmp13 (CfD_p13, x_range)

k_cfd13 = polyder(CfD_p13); % find derivative of above polynomial
r_cfd13 = roots(k_cfd13); % find roots of polynomHHial created from derivative above
r_cfd13 = r_cfd13(r_cfd13>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd13)
  r_cfd13 = r_cfd13(r_cfd13<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd13)
  points_cfd13 = zeros(1,2+length(r_cfd13)); % pre-allocate
  points_cfd13(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd13)
      points_cfd13(2+ii) = r_cfd13(ii);
  end
else
  points_cfd13 = x_range;
end
y_cfd13 = polyval(CfD_p13,points_cfd13);
[max_y_cfd13,xi_cfd13] = max(y_cfd13);
peak_CfD13 = [points_cfd13(xi_cfd13),max_y_cfd13]; % x & y coordinates of peak

end

