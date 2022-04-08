function [k_mer21,r_mer21,points_mer21,y_mer21,max_y_mer21,xi_mer21,peak_Mer21] = MERmp21 (Mer_p21, x_range)

k_mer21 = polyder(Mer_p21); % find derivative of above polynomial
r_mer21 = roots(k_mer21); % find roots of polynomHHial created from derivative above
r_mer21 = r_mer21(r_mer21>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer21)
  r_mer21 = r_mer21(r_mer21<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer21)
  points_mer21 = zeros(1,2+length(r_mer21)); % pre-allocate
  points_mer21(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer21)
      points_mer21(2+ii) = r_mer21(ii);
  end
else
  points_mer21 = x_range;
end
y_mer21 = polyval(Mer_p21,points_mer21);
[max_y_mer21,xi_mer21] = max(y_mer21);
peak_Mer21 = [points_mer21(xi_mer21),max_y_mer21]; % x & y coordinates of peak

end

