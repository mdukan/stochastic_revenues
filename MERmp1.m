function [k_mer1,r_mer1,points_mer1,y_mer1,max_y_mer1,xi_mer1,peak_Mer1] = MERmp1 (Mer_p1, x_range)

k_mer1 = polyder(Mer_p1); % find derivative of above polynomial
r_mer1 = roots(k_mer1); % find roots of polynomHHial created from derivative above
r_mer1 = r_mer1(r_mer1>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer1)
  r_mer1 = r_mer1(r_mer1<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer1)
  points_mer1 = zeros(1,2+length(r_mer1)); % pre-allocate
  points_mer1(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer1)
      points_mer1(2+ii) = r_mer1(ii);
  end
else
  points_mer1 = x_range;
end
y_mer1 = polyval(Mer_p1,points_mer1);
[max_y_mer1,xi_mer1] = max(y_mer1);
peak_Mer1 = [points_mer1(xi_mer1),max_y_mer1]; % x & y coordinates of peak

end

