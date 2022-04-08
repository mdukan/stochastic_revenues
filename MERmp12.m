function [k_mer12,r_mer12,points_mer12,y_mer12,max_y_mer12,xi_mer12,peak_Mer12] = MERmp12 (Mer_p12, x_range)

k_mer12 = polyder(Mer_p12); % find derivative of above polynomial
r_mer12 = roots(k_mer12); % find roots of polynomHHial created from derivative above
r_mer12 = r_mer12(r_mer12>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer12)
  r_mer12 = r_mer12(r_mer12<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer12)
  points_mer12 = zeros(1,2+length(r_mer12)); % pre-allocate
  points_mer12(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer12)
      points_mer12(2+ii) = r_mer12(ii);
  end
else
  points_mer12 = x_range;
end
y_mer12 = polyval(Mer_p12,points_mer12);
[max_y_mer12,xi_mer12] = max(y_mer12);
peak_Mer12 = [points_mer12(xi_mer12),max_y_mer12]; % x & y coordinates of peak

end

