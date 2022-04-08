function [k_mer7,r_mer7,points_mer7,y_mer7,max_y_mer7,xi_mer7,peak_Mer7] = MERmp7 (Mer_p7, x_range)

k_mer7 = polyder(Mer_p7); % find derivative of above polynomial
r_mer7 = roots(k_mer7); % find roots of polynomHHial created from derivative above
r_mer7 = r_mer7(r_mer7>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer7)
  r_mer7 = r_mer7(r_mer7<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer7)
  points_mer7 = zeros(1,2+length(r_mer7)); % pre-allocate
  points_mer7(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer7)
      points_mer7(2+ii) = r_mer7(ii);
  end
else
  points_mer7 = x_range;
end
y_mer7 = polyval(Mer_p7,points_mer7);
[max_y_mer7,xi_mer7] = max(y_mer7);
peak_Mer7 = [points_mer7(xi_mer7),max_y_mer7]; % x & y coordinates of peak

end

