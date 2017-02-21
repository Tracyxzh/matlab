% -*- matlab -*-

% return parameters which are used in bkm_km when mode=2.

function [A1,A2,Ncs,mcs] = bkm_km_parameters(classes,mode,xi,p1,p2,p3,p4);

[tmp,K] = size(classes);
for k=1:K
  [D,Nc] = size(classes{k});
  if Nc > 0
    break;
  end
end

switch mode
 case 2
  mu0 = p1;
  eta0 = p2;
  B0 = p3;
  phi0 = p4;
 case 1
  mu0 = p1;
  a0 = p2;
  b0 = p3;
  phi0 = p4;
end

Ncs = [];
mcs = [];
for c=1:K
  data_c = classes{c};
  [tmp,Nc] = size(data_c);
  Ncs = [Ncs Nc];
  if Nc == 0
    A1(c) = {inf};
    A2(c) = {inf};
    mcs = [mcs zeros(D,1)];
  else
    Xbarc = mean(data_c,2);
    Sc = cov(data_c')*(Nc-1);
    switch mode
     case 2
      NcpXi = Nc+xi;
      mc = (Nc*Xbarc+xi*mu0) / (NcpXi);
      mcs = [mcs mc];
      d = Xbarc - mu0;
      Bc = B0 + Sc + Nc*xi/NcpXi*d*d';
      logDetBc = log(det(Bc));
      etac = eta0 + Nc;
      invBc = inv(Bc);
      A1(c) = {0.5*etac*invBc};
      sum_psi = sum(psi(0.5*( (etac+1)*ones(1,D) - [1:D] )));
      A2(c) = {0.5*logDetBc - 0.5*sum_psi + 0.5*D/(Nc+xi) - psi(Nc+phi0)};
     case 1
      NcpXi = Nc+xi;
      mc = (Nc*Xbarc+xi*mu0) / (NcpXi);
      mcs = [mcs mc];
      d = Xbarc - mu0;
      bc = 0.5*(trace(Sc)+Nc*xi/NcpXi*d'*d) + b0;
      ac = a0 + Nc;
      A1(c) = {0.5*ac/bc};
      A2(c) = {0.5*log(bc) - 0.5*D*psi(ac) + 0.5*D/(Nc+xi) - psi(Nc+phi0)};
     case 0
      mcs = [mcs Xbarc];
      bc = trace(Sc);
      if bc == 0
        bc = 0.1;
        Nc = 1.2;
      end
      Dp2 = 0.5*D;
      A1(c) = {Dp2*(Nc-1)/bc};
      A2(c) = {Dp2/Nc - psi(Nc+1) + Dp2*log(0.5*bc) - Dp2*psi(Dp2* (Nc-1))};
    end
  end
end
