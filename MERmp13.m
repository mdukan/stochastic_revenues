function [k_mer13,r_mer13,points_mer13,y_mer13,max_y_mer13,xi_mer13,peak_Mer13] = MERmp13 (Mer_p13, x_range)

k_mer13 = polyder(Mer_p13); % find derivative of above polynomial
r_mer13 = roots(k_mer13); % find roots of polynomHHial created from derivative above
r_mer13 = r_mer13(r_mer13>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer13)
  r_mer13 = r_mer13(r_mer13<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer13)
  points_mer13 = zeros(1,2+length(r_mer13)); % pre-allocate
  points_mer13(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer13)
      points_mer13(2+ii) = r_mer13(ii);
  end
else
  points_mer13 = x_range;
end
y_mer13 = polyval(Mer_p13,points_mer13);
[max_y_mer13,xi_mer13] = max(y_mer13);
peak_Mer13 = [points_mer13(xi_mer13),max_y_mer13]; % x & y coordinates of peak

end

