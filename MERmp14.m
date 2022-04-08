function [k_mer14,r_mer14,points_mer14,y_mer14,max_y_mer14,xi_mer14,peak_Mer14] = MERmp14 (Mer_p14, x_range)

k_mer14 = polyder(Mer_p14); % find derivative of above polynomial
r_mer14 = roots(k_mer14); % find roots of polynomHHial created from derivative above
r_mer14 = r_mer14(r_mer14>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer14)
  r_mer14 = r_mer14(r_mer14<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer14)
  points_mer14 = zeros(1,2+length(r_mer14)); % pre-allocate
  points_mer14(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer14)
      points_mer14(2+ii) = r_mer14(ii);
  end
else
  points_mer14 = x_range;
end
y_mer14 = polyval(Mer_p14,points_mer14);
[max_y_mer14,xi_mer14] = max(y_mer14);
peak_Mer14 = [points_mer14(xi_mer14),max_y_mer14]; % x & y coordinates of peak

end

