% -*- matlab -*-

% classes: cell array
function cost_table = bkm_km_ct(classes,mode,xi,p1,p2,p3,p4);

K = length(classes);

[A1,A2,Ncs,mcs] = bkm_km_parameters(classes,mode,xi,p1,p2,p3,p4);


% make cost_table
n = 1;
for old_c=1:K
  data_c = classes{old_c};
  for nc=1:Ncs(old_c)
    x = data_c(:,nc);
    for c_tmp=1:K
      d = x-mcs(:,c_tmp);
      cost_table(c_tmp,n) = trace(A1{c_tmp}*d*d') + A2{c_tmp};
    end
    n = n + 1;
  end
end
