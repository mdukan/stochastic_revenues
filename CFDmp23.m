function [k_cfd23,r_cfd23,points_cfd23,y_cfd23,max_y_cfd23,xi_cfd23,peak_CfD23] = CFDmp23 (CfD_p23, x_range)

k_cfd23 = polyder(CfD_p23); % find derivative of above polynomial
r_cfd23 = roots(k_cfd23); % find roots of polynomHHial created from derivative above
r_cfd23 = r_cfd23(r_cfd23>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd23)
  r_cfd23 = r_cfd23(r_cfd23<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd23)
  points_cfd23 = zeros(1,2+length(r_cfd23)); % pre-allocate
  points_cfd23(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd23)
      points_cfd23(2+ii) = r_cfd23(ii);
  end
else
  points_cfd23 = x_range;
end
y_cfd23 = polyval(CfD_p23,points_cfd23);
[max_y_cfd23,xi_cfd23] = max(y_cfd23);
peak_CfD23 = [points_cfd23(xi_cfd23),max_y_cfd23]; % x & y coordinates of peak

end

