function [k_mer23,r_mer23,points_mer23,y_mer23,max_y_mer23,xi_mer23,peak_Mer23] = MERmp23 (Mer_p23, x_range)

k_mer23 = polyder(Mer_p23); % find derivative of above polynomial
r_mer23 = roots(k_mer23); % find roots of polynomHHial created from derivative above
r_mer23 = r_mer23(r_mer23>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer23)
  r_mer23 = r_mer23(r_mer23<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer23)
  points_mer23 = zeros(1,2+length(r_mer23)); % pre-allocate
  points_mer23(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer23)
      points_mer23(2+ii) = r_mer23(ii);
  end
else
  points_mer23 = x_range;
end
y_mer23 = polyval(Mer_p23,points_mer23);
[max_y_mer23,xi_mer23] = max(y_mer23);
peak_Mer23 = [points_mer23(xi_mer23),max_y_mer23]; % x & y coordinates of peak

end

