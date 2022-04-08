function [k_mer4,r_mer4,points_mer4,y_mer4,max_y_mer4,xi_mer4,peak_Mer4] = MERmp4 (Mer_p4, x_range)

k_mer4 = polyder(Mer_p4); % find derivative of above polynomial
r_mer4 = roots(k_mer4); % find roots of polynomHHial created from derivative above
r_mer4 = r_mer4(r_mer4>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer4)
  r_mer4 = r_mer4(r_mer4<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer4)
  points_mer4 = zeros(1,2+length(r_mer4)); % pre-allocate
  points_mer4(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer4)
      points_mer4(2+ii) = r_mer4(ii);
  end
else
  points_mer4 = x_range;
end
y_mer4 = polyval(Mer_p4,points_mer4);
[max_y_mer4,xi_mer4] = max(y_mer4);
peak_Mer4 = [points_mer4(xi_mer4),max_y_mer4]; % x & y coordinates of peak

end

