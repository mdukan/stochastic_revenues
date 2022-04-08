function [k_mer3,r_mer3,points_mer3,y_mer3,max_y_mer3,xi_mer3,peak_Mer3] = MERmp3 (Mer_p3, x_range)

k_mer3 = polyder(Mer_p3); % find derivative of above polynomial
r_mer3 = roots(k_mer3); % find roots of polynomHHial created from derivative above
r_mer3 = r_mer3(r_mer3>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer3)
  r_mer3 = r_mer3(r_mer3<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer3)
  points_mer3 = zeros(1,2+length(r_mer3)); % pre-allocate
  points_mer3(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer3)
      points_mer3(2+ii) = r_mer3(ii);
  end
else
  points_mer3 = x_range;
end
y_mer3 = polyval(Mer_p3,points_mer3);
[max_y_mer3,xi_mer3] = max(y_mer3);
peak_Mer3 = [points_mer3(xi_mer3),max_y_mer3]; % x & y coordinates of peak

end

