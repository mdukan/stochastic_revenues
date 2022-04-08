function [k_mer5,r_mer5,points_mer5,y_mer5,max_y_mer5,xi_mer5,peak_Mer5] = MERmp5 (Mer_p5, x_range)

k_mer5 = polyder(Mer_p5); % find derivative of above polynomial
r_mer5 = roots(k_mer5); % find roots of polynomHHial created from derivative above
r_mer5 = r_mer5(r_mer5>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer5)
  r_mer5 = r_mer5(r_mer5<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer5)
  points_mer5 = zeros(1,2+length(r_mer5)); % pre-allocate
  points_mer5(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer5)
      points_mer5(2+ii) = r_mer5(ii);
  end
else
  points_mer5 = x_range;
end
y_mer5 = polyval(Mer_p5,points_mer5);
[max_y_mer5,xi_mer5] = max(y_mer5);
peak_Mer5 = [points_mer5(xi_mer5),max_y_mer5]; % x & y coordinates of peak

end

