% -*- matlab -*-

function [maxdist,h] = bkm_owner_maxdist(h,classes,c);

id = classes(c).id;
if (id<=length(h.maxdist_cached)) & h.maxdist_cached(id)
  maxdist = h.maxdist(id);
else
  D = length(h.lb);
  if D <= 8
    % METHOD 1; search over all of the corners of the box
    corners = h.corners;
    corners_len = 2^D;
    d = corners - classes(c).mc*ones(1,corners_len);
    costs = sum(d.*(classes(c).A*d),1) + classes(c).a*ones(1,corners_len);
    maxdist = max(costs);

  else
    % METHOD 2; use the upper bound of the distance
    % x'*A*x <= lambda_max * sum_i x_i^2
    [vec,lambda_max] = power_method(classes(c).A);
    mc = classes(c).mc;
    d1 = h.lb-mc;
    d2 = h.ub-mc;
    maxdist = lambda_max*sum(max([d1.*d1; d2.*d2],[],2)) + classes(c).a;
  end
  
  % cache
  h.maxdist_cached(id) = 1;
  h.maxdist(id) = maxdist;
end
