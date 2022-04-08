function [k_mer2,r_mer2,points_mer2,y_mer2,max_y_mer2,xi_mer2,peak_Mer2] = MERmp2 (Mer_p2, x_range)

k_mer2 = polyder(Mer_p2); % find derivative of above polynomial
r_mer2 = roots(k_mer2); % find roots of polynomHHial created from derivative above
r_mer2 = r_mer2(r_mer2>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer2)
  r_mer2 = r_mer2(r_mer2<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer2)
  points_mer2 = zeros(1,2+length(r_mer2)); % pre-allocate
  points_mer2(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer2)
      points_mer2(2+ii) = r_mer2(ii);
  end
else
  points_mer2 = x_range;
end
y_mer2 = polyval(Mer_p2,points_mer2);
[max_y_mer2,xi_mer2] = max(y_mer2);
peak_Mer2 = [points_mer2(xi_mer2),max_y_mer2]; % x & y coordinates of peak

end

