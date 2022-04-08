function [k_mer16,r_mer16,points_mer16,y_mer16,max_y_mer16,xi_mer16,peak_Mer16] = MERmp16 (Mer_p16, x_range)

k_mer16 = polyder(Mer_p16); % find derivative of above polynomial
r_mer16 = roots(k_mer16); % find roots of polynomHHial created from derivative above
r_mer16 = r_mer16(r_mer16>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer16)
  r_mer16 = r_mer16(r_mer16<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer16)
  points_mer16 = zeros(1,2+length(r_mer16)); % pre-allocate
  points_mer16(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer16)
      points_mer16(2+ii) = r_mer16(ii);
  end
else
  points_mer16 = x_range;
end
y_mer16 = polyval(Mer_p16,points_mer16);
[max_y_mer16,xi_mer16] = max(y_mer16);
peak_Mer16 = [points_mer16(xi_mer16),max_y_mer16]; % x & y coordinates of peak

end

