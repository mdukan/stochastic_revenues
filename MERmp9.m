function [k_mer9,r_mer9,points_mer9,y_mer9,max_y_mer9,xi_mer9,peak_Mer9] = MERmp9 (Mer_p9, x_range)

k_mer9 = polyder(Mer_p9); % find derivative of above polynomial
r_mer9 = roots(k_mer9); % find roots of polynomHHial created from derivative above
r_mer9 = r_mer9(r_mer9>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer9)
  r_mer9 = r_mer9(r_mer9<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer9)
  points_mer9 = zeros(1,2+length(r_mer9)); % pre-allocate
  points_mer9(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer9)
      points_mer9(2+ii) = r_mer9(ii);
  end
else
  points_mer9 = x_range;
end
y_mer9 = polyval(Mer_p9,points_mer9);
[max_y_mer9,xi_mer9] = max(y_mer9);
peak_Mer9 = [points_mer9(xi_mer9),max_y_mer9]; % x & y coordinates of peak

end

