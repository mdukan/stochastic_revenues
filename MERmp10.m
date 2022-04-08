function [k_mer10,r_mer10,points_mer10,y_mer10,max_y_mer10,xi_mer10,peak_Mer10] = MERmp10 (Mer_p10, x_range)

k_mer10 = polyder(Mer_p10); % find derivative of above polynomial
r_mer10 = roots(k_mer10); % find roots of polynomHHial created from derivative above
r_mer10 = r_mer10(r_mer10>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer10)
  r_mer10 = r_mer10(r_mer10<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer10)
  points_mer10 = zeros(1,2+length(r_mer10)); % pre-allocate
  points_mer10(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer10)
      points_mer10(2+ii) = r_mer10(ii);
  end
else
  points_mer10 = x_range;
end
y_mer10 = polyval(Mer_p10,points_mer10);
[max_y_mer10,xi_mer10] = max(y_mer10);
peak_Mer10 = [points_mer10(xi_mer10),max_y_mer10]; % x & y coordinates of peak

end

