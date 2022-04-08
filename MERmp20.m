function [k_mer20,r_mer20,points_mer20,y_mer20,max_y_mer20,xi_mer20,peak_Mer20] = MERmp20 (Mer_p20, x_range)

k_mer20 = polyder(Mer_p20); % find derivative of above polynomial
r_mer20 = roots(k_mer20); % find roots of polynomHHial created from derivative above
r_mer20 = r_mer20(r_mer20>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer20)
  r_mer20 = r_mer20(r_mer20<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer20)
  points_mer20 = zeros(1,2+length(r_mer20)); % pre-allocate
  points_mer20(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer20)
      points_mer20(2+ii) = r_mer20(ii);
  end
else
  points_mer20 = x_range;
end
y_mer20 = polyval(Mer_p20,points_mer20);
[max_y_mer20,xi_mer20] = max(y_mer20);
peak_Mer20 = [points_mer20(xi_mer20),max_y_mer20]; % x & y coordinates of peak

end

