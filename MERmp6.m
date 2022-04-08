function [k_mer6,r_mer6,points_mer6,y_mer6,max_y_mer6,xi_mer6,peak_Mer6] = MERmp6 (Mer_p6, x_range)

k_mer6 = polyder(Mer_p6); % find derivative of above polynomial
r_mer6 = roots(k_mer6); % find roots of polynomHHial created from derivative above
r_mer6 = r_mer6(r_mer6>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer6)
  r_mer6 = r_mer6(r_mer6<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer6)
  points_mer6 = zeros(1,2+length(r_mer6)); % pre-allocate
  points_mer6(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer6)
      points_mer6(2+ii) = r_mer6(ii);
  end
else
  points_mer6 = x_range;
end
y_mer6 = polyval(Mer_p6,points_mer6);
[max_y_mer6,xi_mer6] = max(y_mer6);
peak_Mer6 = [points_mer6(xi_mer6),max_y_mer6]; % x & y coordinates of peak

end

