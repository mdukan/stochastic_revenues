function [k_cfd9,r_cfd9,points_cfd9,y_cfd9,max_y_cfd9,xi_cfd9,peak_CfD9] = CFDmp9 (CfD_p9, x_range)

k_cfd9 = polyder(CfD_p9); % find derivative of above polynomial
r_cfd9 = roots(k_cfd9); % find roots of polynomHHial created from derivative above
r_cfd9 = r_cfd9(r_cfd9>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd9)
  r_cfd9 = r_cfd9(r_cfd9<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd9)
  points_cfd9 = zeros(1,2+length(r_cfd9)); % pre-allocate
  points_cfd9(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd9)
      points_cfd9(2+ii) = r_cfd9(ii);
  end
else
  points_cfd9 = x_range;
end
y_cfd9 = polyval(CfD_p9,points_cfd9);
[max_y_cfd9,xi_cfd9] = max(y_cfd9);
peak_CfD9 = [points_cfd9(xi_cfd9),max_y_cfd9]; % x & y coordinates of peak

end

