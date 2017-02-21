% -*- matlab -*-
%
function [classes,F,root] = bkm_kmkd(K,classes,mode,xi,p1,p2,p3,p4,root);

if mode ~= 2
  error('support only mode=2');
end

mu0 = p1;
eta0 = p2;
B0 = p3;
phi0 = p4;

D = length(mu0);
K = length(classes);


loop=0;
while sum([classes.updated]) > 0
  loop = loop + 1;
  [stats,root] = bkm_traverse_tree(root,classes);
  for c=1:K
    [tmp,old_Nc] = size(classes(c).data);
    updated = 0;
    if old_Nc ~= stats(c).Nc
      updated = 1;
    elseif stats(c).Nc ~= 0
      if classes(c).data == stats(c).data;
      else
        updated = 1;
      end
    end
    % update classes
    if updated
      classes(c) = bkm_mkclass(stats(c),xi,p1,p2,p3,p4);
    else
      classes(c) = classes(c);
      classes(c).updated = 0;
    end
  end % for c=1:K
end
% loop

% check empty classes
classes(find([classes(:).Nc]==0)) = [];
K = length(classes);

% calculate F with stats
sum_xx_cell = [{classes(:).sum_xx}];
F = bkm_Fc_stats([classes(:).sum_x],sum_xx_cell,[classes(:).Nc],p1,p2,p3,p4,xi);
