function [k_mer8,r_mer8,points_mer8,y_mer8,max_y_mer8,xi_mer8,peak_Mer8] = MERmp8 (Mer_p8, x_range)

k_mer8 = polyder(Mer_p8); % find derivative of above polynomial
r_mer8 = roots(k_mer8); % find roots of polynomHHial created from derivative above
r_mer8 = r_mer8(r_mer8>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer8)
  r_mer8 = r_mer8(r_mer8<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer8)
  points_mer8 = zeros(1,2+length(r_mer8)); % pre-allocate
  points_mer8(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer8)
      points_mer8(2+ii) = r_mer8(ii);
  end
else
  points_mer8 = x_range;
end
y_mer8 = polyval(Mer_p8,points_mer8);
[max_y_mer8,xi_mer8] = max(y_mer8);
peak_Mer8 = [points_mer8(xi_mer8),max_y_mer8]; % x & y coordinates of peak

end

