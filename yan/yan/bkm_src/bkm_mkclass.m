% -*- matlab -*-

% val is data or stats.
function class = bkm_mkclass(val,xi,p1,p2,p3,p4);

global bkm_mkclass_last_id;

if isempty(bkm_mkclass_last_id)
  bkm_mkclass_last_id = 0;
end

mu0 = p1;
eta0 = p2;
B0 = p3;
phi0 = p4;

D = length(mu0);

class.updated = 1;
% global mkkdtree_last_id
% class.h(1:mkkdtree_last_id) = struct('was_owner',0, 'did_share',0);
if isstruct(val)
  stats = val;
  [tmp,Nc] = size(stats.data);
  data = stats.data;
  sum_x = stats.sum_x;
  sum_xx = stats.sum_xx;
else
  data = val;
  [tmp,Nc] = size(data);
  % should be the same as stats.sum_x/sum_xx
  if Nc == 0
    sum_x = zeros(D,1);
    sum_xx = zeros(D);
  else
    sum_x = sum(data,2);
    sum_xx = data*data';
  end
end
class.sum_x = sum_x; % Dx1
class.sum_xx = sum_xx;

class.data = data;
class.Nc = Nc;
if Nc == 0
  class.A = inf; % this can be a scalar
  class.a = inf;
  class.mc = zeros(D,1);
else
  x_bar = sum_x / Nc;
  d = x_bar-mu0;
  etac = Nc + eta0;
  Bc = B0 + sum_xx - Nc*x_bar*x_bar' + Nc*xi/(Nc+xi)*d*d';
  % det(Bc/Nc) = det(Bc) / Nc^D
  % log(det(Bc)) = log(det(Bc/Nc)) + D*log(Nc);
  logDetBc = D*log(Nc) + log(det(Bc/(Nc)));
  % inv(Bc) is theoretically symmetric, but it can be
  % non-symmetric due to calculation round-off errors.
  invBc = inv(Bc);
  invBc = 0.5*(invBc+invBc');
  class.A = 0.5*etac*invBc;
  sum_psi = sum(psi(0.5*( (etac+1)*ones(1,D) - [1:D] )));
  class.a = 0.5*logDetBc - 0.5*sum_psi + 0.5*D/(Nc+xi) - psi(Nc+phi0);
  class.mc = (Nc*x_bar+xi*mu0) / (Nc+xi);
end

A = class.A;
if A == inf
  class.lambda_min = inf;
elseif abs(det(A)) <= 1.0e-10
  class.lambda_min = 0;
else
  if D<=12
    class.lambda_min = min(eig(A));
  else
    invA = inv(A);
    [vec,lambda_min] = power_method(invA);
    class.lambda_min = 1/lambda_min;
  end
end

bkm_mkclass_last_id = bkm_mkclass_last_id + 1;
class.id = bkm_mkclass_last_id;
