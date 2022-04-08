function [k_cfd3,r_cfd3,points_cfd3,y_cfd3,max_y_cfd3,xi_cfd3,peak_CfD3] = CFDmp3 (CfD_p3, x_range)

k_cfd3 = polyder(CfD_p3); % find derivative of above polynomial
r_cfd3 = roots(k_cfd3); % find roots of polynomHHial created from derivative above
r_cfd3 = r_cfd3(r_cfd3>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd3)
  r_cfd3 = r_cfd3(r_cfd3<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd3)
  points_cfd3 = zeros(1,2+length(r_cfd3)); % pre-allocate
  points_cfd3(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd3)
      points_cfd3(2+ii) = r_cfd3(ii);
  end
else
  points_cfd3 = x_range;
end
y_cfd3 = polyval(CfD_p3,points_cfd3);
[max_y_cfd3,xi_cfd3] = max(y_cfd3);
peak_CfD3 = [points_cfd3(xi_cfd3),max_y_cfd3]; % x & y coordinates of peak

end

