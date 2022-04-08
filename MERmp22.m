function [k_mer22,r_mer22,points_mer22,y_mer22,max_y_mer22,xi_mer22,peak_Mer22] = MERmp22 (Mer_p22, x_range)

k_mer22 = polyder(Mer_p22); % find derivative of above polynomial
r_mer22 = roots(k_mer22); % find roots of polynomHHial created from derivative above
r_mer22 = r_mer22(r_mer22>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer22)
  r_mer22 = r_mer22(r_mer22<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer22)
  points_mer22 = zeros(1,2+length(r_mer22)); % pre-allocate
  points_mer22(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer22)
      points_mer22(2+ii) = r_mer22(ii);
  end
else
  points_mer22 = x_range;
end
y_mer22 = polyval(Mer_p22,points_mer22);
[max_y_mer22,xi_mer22] = max(y_mer22);
peak_Mer22 = [points_mer22(xi_mer22),max_y_mer22]; % x & y coordinates of peak

end

