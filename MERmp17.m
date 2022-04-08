function [k_mer17,r_mer17,points_mer17,y_mer17,max_y_mer17,xi_mer17,peak_Mer17] = MERmp17 (Mer_p17, x_range)

k_mer17 = polyder(Mer_p17); % find derivative of above polynomial
r_mer17 = roots(k_mer17); % find roots of polynomHHial created from derivative above
r_mer17 = r_mer17(r_mer17>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer17)
  r_mer17 = r_mer17(r_mer17<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer17)
  points_mer17 = zeros(1,2+length(r_mer17)); % pre-allocate
  points_mer17(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer17)
      points_mer17(2+ii) = r_mer17(ii);
  end
else
  points_mer17 = x_range;
end
y_mer17 = polyval(Mer_p17,points_mer17);
[max_y_mer17,xi_mer17] = max(y_mer17);
peak_Mer17 = [points_mer17(xi_mer17),max_y_mer17]; % x & y coordinates of peak

end

