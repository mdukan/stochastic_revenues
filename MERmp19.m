function [k_mer19,r_mer19,points_mer19,y_mer19,max_y_mer19,xi_mer19,peak_Mer19] = MERmp19 (Mer_p19, x_range)

k_mer19 = polyder(Mer_p19); % find derivative of above polynomial
r_mer19 = roots(k_mer19); % find roots of polynomHHial created from derivative above
r_mer19 = r_mer19(r_mer19>=x_range(1)); % get rid of roots less than x_min
if ~isempty(r_mer19)
  r_mer19 = r_mer19(r_mer19<=x_range(2)); % get rid of roots greater than x_max
end
if ~isempty(r_mer19)
  points_mer19 = zeros(1,2+length(r_mer19)); % pre-allocate
  points_mer19(1:2) = x_range; % add x_min and x_max to list to try
  for ii = 1 : length(r_mer19)
      points_mer19(2+ii) = r_mer19(ii);
  end
else
  points_mer19 = x_range;
end
y_mer19 = polyval(Mer_p19,points_mer19);
[max_y_mer19,xi_mer19] = max(y_mer19);
peak_Mer19 = [points_mer19(xi_mer19),max_y_mer19]; % x & y coordinates of peak

end

