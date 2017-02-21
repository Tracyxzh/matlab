% -*- matlab -*-

function corners = bkm_kd_mkcorners(lb,ub,dim);

D=length(lb);
if D==dim
  p1 = zeros(D,1);
  p2 = p1;
  p1(dim) = lb(dim);
  p2(dim) = ub(dim);
  corners = [p1 p2];
else
  corners = bkm_kd_mkcorners(lb,ub,dim+1);
  corners1 = corners;
  corners2 = corners;
  corners1(dim,:) = lb(dim);
  corners2(dim,:) = ub(dim);
  corners = [corners1 corners2];
end
