% -*- matlab -*-
%
function [classes,F,kdtree] = bkm_km(K,classes,mode,xi,p1,p2,p3, ...
                                     p4,use_kd,kdtree);
switch nargin
 case 8 % up to p4
 case 10 % all arguments
  if use_kd
    [classes F kdtree] = bkm_kmkd(K,classes,mode,xi,p1,p2,p3,p4,kdtree);
    return
  end
 otherwise
  error('invalid number of arguments.');
end

mu0 = p1;
D = length(mu0);
K = length(classes);
for i=1:K
  data_c{i} = classes(i).data;
end

updated = ones(1,K);

loop=0;
last_updated = updated+ones(1,K);
while sum(updated-last_updated) ~= 0
  loop = loop + 1;
  last_updated = updated;
  cost_table = bkm_km_ct(data_c,mode,xi,p1,p2,p3,p4);
  for k=1:K
    new_data_c(k) = {[]};
  end
  % re-assign
  n = 1;
  for old_c=1:K
    data = data_c{old_c};
    [tmp,Nc] = size(data);
    for nc=1:Nc
      x = data(:,nc);
      [min_cost,best_class] = min(cost_table(:,n));
      updated(old_c) = updated(old_c) + (old_c~=best_class);
      updated(best_class) = updated(best_class) + (old_c~=best_class);
      new_data_c(best_class) = {[new_data_c{best_class},x]};
      n = n + 1;
    end
  end
  data_c = new_data_c;
end
% loop

% check empty data_c
K = length(data_c);
for i=1:K
  c = K+1-i;
  Nc = size(data_c{c},2);
  if Nc == 0
    data_c(c) = [];
  end
end
K = length(data_c);

clear classes;
for i=1:K
  classes(i) = bkm_mkclass(data_c{i},xi,p1,p2,p3,p4);
end
sum_xx_cell = [{classes(:).sum_xx}];
F = bkm_Fc_stats([classes(:).sum_x],sum_xx_cell,[classes(:).Nc],p1,p2,p3,p4,xi);
