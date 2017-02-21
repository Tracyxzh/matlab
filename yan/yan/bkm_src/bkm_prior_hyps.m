%% -*- matlab -*-

function [p1,p2,p3,p4,p5,p6] = bkm_prior_hyps(mode,data,xi,b0r,S);

[D,N] = size(data);

switch mode
 case 2 % non-isotoropic
  mu0 = mean(data,2);
  % eta0 must be greater or equal to D.
  eta0 = D;
  B0 = b0r*D*S;
  phi0 = 2;
  p1 = mu0;
  p2 = eta0;
  p3 = B0;
  p4 = phi0;
  p5 = xi;
  p6 = phi0;
 case 1 % conjugate
  mu0 = mean(data,2);
  Sc = trace(cov(data'));
  a0 = D * 0.5;
  b0 = Sc * 0.5;
  phi0 = 2;
  p1 = mu0;
  p2 = a0;
  p3 = b0;
  p4 = phi0;
  p5 = xi;
  p6 = phi0;
 case 0 % Jeffery's
  mu_min = min(min(data));
  mu_max = max(max(data));
  nu_min = D/sum(var([mu_min,mu_max]'));
  nu_max = 0;
  for i=1:N
    for j=i+1:N
      nu = D/sum(var([data(:,i),data(:,j)]));
      if nu > nu_max
        nu_max = nu;
      end
    end
  end
  p1 = mu_max;
  p2 = mu_min;
  p3 = nu_max;
  p4 = nu_min;
  p5 = 0; % dummy
  p6 = 0; % dummy
end
