% -*- matlab -*-
%
% x: array(1,K)
% p: scalor
function val = gamma_multivariate_ln(x,p);
% x must be more than (p-1)/2
% x should be more than p/2

% Gamma_p(x) = pi^(p(p-1)/4) prod_(j=1)^p Gamma(x+(1-j)/2)
% log Gamma_p(x) = p(p-1)/4 log pi + sum_(j=1)^p log Gamma(x+(1-j)/2)

K = length(x);
gammaln_val = gammaln(ones(p,1)*x+[1-p:0]'*0.5*ones(1,K));
val = p*(p-1)*0.25 * log(pi)*ones(1,K) + sum(gammaln_val,1);
