% -*- matlab -*-
%
% mode = 0 -> isotoropic with Jeffery's
% mode = 1 -> isotoropic with conjugate
% mode = 2 -> non-isotoropic with conjugate

function term_K = bkm_term_K(N,K,mode,phi0);

switch mode
 case 2 % non-isotoropic
  term_K = gammaln(N+K*phi0) - gammaln(K*phi0);
 case 1 % conjugate
  term_K = gammaln(N+K*phi0) - gammaln(K*phi0);
 case 0 % Jeffery's
  term_K = gammaln(N+K) - gammaln(K);
end
