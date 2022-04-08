function [k_mer11,r_mer11,points_mer11,y_mer11,max_y_mer11,xi_mer11,peak_Mer11] = MERmp11 (Mer_p11, x_range)

k_mer11 = polyder(Mer_p11); % find derivative of above polynomial
r_mer11 = roots(k_mer11); % find roots of polynomHHial created from derivative above
r_mer11 = r_mer11(r_mer11>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer11)
  r_mer11 = r_mer11(r_mer11<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer11)
  points_mer11 = zeros(1,2+length(r_mer11)); % pre-allocate
  points_mer11(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer11)
      points_mer11(2+ii) = r_mer11(ii);
  end
else
  points_mer11 = x_range;
end
y_mer11 = polyval(Mer_p11,points_mer11);
[max_y_mer11,xi_mer11] = max(y_mer11);
peak_Mer11 = [points_mer11(xi_mer11),max_y_mer11]; % x & y coordinates of peak

end

