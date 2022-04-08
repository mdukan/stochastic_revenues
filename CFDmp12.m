function [k_cfd12,r_cfd12,points_cfd12,y_cfd12,max_y_cfd12,xi_cfd12,peak_CfD12] = CFDmp12 (CfD_p12, x_range)

k_cfd12 = polyder(CfD_p12); % find derivative of above polynomial
r_cfd12 = roots(k_cfd12); % find roots of polynomHHial created from derivative above
r_cfd12 = r_cfd12(r_cfd12>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd12)
  r_cfd12 = r_cfd12(r_cfd12<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd12)
  points_cfd12 = zeros(1,2+length(r_cfd12)); % pre-allocate
  points_cfd12(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd12)
      points_cfd12(2+ii) = r_cfd12(ii);
  end
else
  points_cfd12 = x_range;
end
y_cfd12 = polyval(CfD_p12,points_cfd12);
[max_y_cfd12,xi_cfd12] = max(y_cfd12);
peak_CfD12 = [points_cfd12(xi_cfd12),max_y_cfd12]; % x & y coordinates of peak

end

