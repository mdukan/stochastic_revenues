function [k_cfd19,r_cfd19,points_cfd19,y_cfd19,max_y_cfd19,xi_cfd19,peak_CfD19] = CFDmp19 (CfD_p19, x_range)

k_cfd19 = polyder(CfD_p19); % find derivative of above polynomial
r_cfd19 = roots(k_cfd19); % find roots of polynomHHial created from derivative above
r_cfd19 = r_cfd19(r_cfd19>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_cfd19)
  r_cfd19 = r_cfd19(r_cfd19<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_cfd19)
  points_cfd19 = zeros(1,2+length(r_cfd19)); % pre-allocate
  points_cfd19(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_cfd19)
      points_cfd19(2+ii) = r_cfd19(ii);
  end
else
  points_cfd19 = x_range;
end
y_cfd19 = polyval(CfD_p19,points_cfd19);
[max_y_cfd19,xi_cfd19] = max(y_cfd19);
peak_CfD19 = [points_cfd19(xi_cfd19),max_y_cfd19]; % x & y coordinates of peak

end

