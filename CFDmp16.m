function [k_cfd16,r_cfd16,points_cfd16,y_cfd16,max_y_cfd16,xi_cfd16,peak_CfD16] = CFDmp16 (CfD_p16, x_range)

k_cfd16 = polyder(CfD_p16); % find derivative of above polynomial
r_cfd16 = roots(k_cfd16); % find roots of polynomHHial created from derivative above
r_cfd16 = r_cfd16(r_cfd16>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd16)
  r_cfd16 = r_cfd16(r_cfd16<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd16)
  points_cfd16 = zeros(1,2+length(r_cfd16)); % pre-allocate
  points_cfd16(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd16)
      points_cfd16(2+ii) = r_cfd16(ii);
  end
else
  points_cfd16 = x_range;
end
y_cfd16 = polyval(CfD_p16,points_cfd16);
[max_y_cfd16,xi_cfd16] = max(y_cfd16);
peak_CfD16 = [points_cfd16(xi_cfd16),max_y_cfd16]; % x & y coordinates of peak

end

