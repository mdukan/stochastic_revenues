function [k_mer18,r_mer18,points_mer18,y_mer18,max_y_mer18,xi_mer18,peak_Mer18] = MERmp18 (Mer_p18, x_range)

k_mer18 = polyder(Mer_p18); % find derivative of above polynomial
r_mer18 = roots(k_mer18); % find roots of polynomHHial created from derivative above
r_mer18 = r_mer18(r_mer18>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer18)
  r_mer18 = r_mer18(r_mer18<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer18)
  points_mer18 = zeros(1,2+length(r_mer18)); % pre-allocate
  points_mer18(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer18)
      points_mer18(2+ii) = r_mer18(ii);
  end
else
  points_mer18 = x_range;
end
y_mer18 = polyval(Mer_p18,points_mer18);
[max_y_mer18,xi_mer18] = max(y_mer18);
peak_Mer18 = [points_mer18(xi_mer18),max_y_mer18]; % x & y coordinates of peak

end

