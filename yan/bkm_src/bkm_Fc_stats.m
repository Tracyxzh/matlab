% -*- matlab -*-
%
% sum_x:  array(D,K);
% sum_xx: cell(1,K);
% Nc: array(1,K); Nc(c) ~= 0 for all c
% Fc: array(1,K);
function Fc = bkm_Fc_stats(sum_x,sum_xx,Nc,p1,p2,p3,p4,p5);

K = length(Nc);
[D,tmp] = size(p1); % mu0

mu0 = p1*ones(1,K);
eta0 = p2*ones(1,K);
B0 = p3;
phi0 = p4*ones(1,K);
xi = p5;

Xbarc = sum_x./(ones(D,1)*Nc);
NcpXi = Nc+ones(1,K)*xi;
mc = (ones(D,1)*Nc.*Xbarc+xi*mu0) ./ (ones(D,1)*(NcpXi));
XiSlashNcpXi = xi./NcpXi;
NcTimesXiSlashNcpXi = Nc.*XiSlashNcpXi;
for i=1:K
  Sc = sum_xx{i} - Nc(i)*Xbarc(:,i)*Xbarc(:,i)';
  d = Xbarc(:,i) - mu0(:,i);
  Bc = B0 + Sc + NcTimesXiSlashNcpXi(i)*d*d';
  logDetBc(i) = detln(Bc);
  XbarcTmc = Xbarc(:,i)*mc(:,i)';
  Sc_conj = sum_xx{i} + Nc(i)*( - XbarcTmc - XbarcTmc' + mc(:,i)*mc(:,i)' );
  d = mc(:,i) - mu0(:,i);
  tr(i) = trace(inv(Bc)*(xi*d*d'+Sc_conj+B0));
end
etac = eta0 + Nc;
logDetB0 = ones(1,K)*detln(B0);

Fc = 0.5*D*Nc*log(pi) - 0.5*log(XiSlashNcpXi) + 0.5*etac.*logDetBc ...
     - 0.5*D*etac + gamma_multivariate_ln(eta0*0.5,D) - ...
     gamma_multivariate_ln(etac*0.5,D) + gammaln(phi0) - ...
     gammaln(Nc+phi0) + 0.5*etac.*tr ...
     - 0.5*eta0.*logDetB0;

if isnan(Fc) | isinf(Fc) | ~isreal(Fc)
  Fc
  error('Fc is nan, inf or complex')
end
