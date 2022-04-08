function [k_mer24,r_mer24,points_mer24,y_mer24,max_y_mer24,xi_mer24,peak_Mer24] = MERmp24 (Mer_p24, x_range)

k_mer24 = polyder(Mer_p24); % find derivative of above polynomial
r_mer24 = roots(k_mer24); % find roots of polynomHHial created from derivative above
r_mer24 = r_mer24(r_mer24>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer24)
  r_mer24 = r_mer24(r_mer24<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer24)
  points_mer24 = zeros(1,2+length(r_mer24)); % pre-allocate
  points_mer24(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer24)
      points_mer24(2+ii) = r_mer24(ii);
  end
else
  points_mer24 = x_range;
end
y_mer24 = polyval(Mer_p24,points_mer24);
[max_y_mer24,xi_mer24] = max(y_mer24);
peak_Mer24 = [points_mer24(xi_mer24),max_y_mer24]; % x & y coordinates of peak

end

