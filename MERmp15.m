function [k_mer15,r_mer15,points_mer15,y_mer15,max_y_mer15,xi_mer15,peak_Mer15] = MERmp15 (Mer_p15, x_range)

k_mer15 = polyder(Mer_p15); % find derivative of above polynomial
r_mer15 = roots(k_mer15); % find roots of polynomHHial created from derivative above
r_mer15 = r_mer15(r_mer15>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer15)
  r_mer15 = r_mer15(r_mer15<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer15)
  points_mer15 = zeros(1,2+length(r_mer15)); % pre-allocate
  points_mer15(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer15)
      points_mer15(2+ii) = r_mer15(ii);
  end
else
  points_mer15 = x_range;
end
y_mer15 = polyval(Mer_p15,points_mer15);
[max_y_mer15,xi_mer15] = max(y_mer15);
peak_Mer15 = [points_mer15(xi_mer15),max_y_mer15]; % x & y coordinates of peak

end

