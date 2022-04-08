function [k_cfd2,r_cfd2,points_cfd2,y_cfd2,max_y_cfd2,xi_cfd2,peak_CfD2] = CFDmp2 (CfD_p2, x_range)

k_cfd2 = polyder(CfD_p2); % find derivative of above polynomial
r_cfd2 = roots(k_cfd2); % find roots of polynomHHial created from derivative above
r_cfd2 = r_cfd2(r_cfd2>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd2)
  r_cfd2 = r_cfd2(r_cfd2<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd2)
  points_cfd2 = zeros(1,2+length(r_cfd2)); % pre-allocate
  points_cfd2(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd2)
      points_cfd2(2+ii) = r_cfd2(ii);
  end
else
  points_cfd2 = x_range;
end
y_cfd2 = polyval(CfD_p2,points_cfd2);
[max_y_cfd2,xi_cfd2] = max(y_cfd2);
peak_CfD2 = [points_cfd2(xi_cfd2),max_y_cfd2]; % x & y coordinates of peak

end

