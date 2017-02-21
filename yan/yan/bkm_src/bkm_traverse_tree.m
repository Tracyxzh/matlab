% -*- matlab -*-

% h: kd-tree
function [stats,h] = bkm_traverse_tree(h,classes,prospectives);

mcs = [classes.mc];
[D,K] = size(mcs);

switch nargin
 case 2 % up to classes
  prospectives = 1:K;
 case 3 % up to prospectives
 otherwise
  error( 'invalid number of arguments' );
end

[owner,prospectives,h] = bkm_owner(h,classes,prospectives);

%% there exists owner
if owner >= 1
  for c=[1:owner-1 owner+1:K]
    stats(c).sum_x = zeros(D,1);
    stats(c).sum_xx = zeros(D,D);
    stats(c).Nc = 0;
    stats(c).data = [];
  end
  stats(owner).sum_x = h.sum_x;
  stats(owner).sum_xx = h.sum_xx;
  stats(owner).Nc = h.Nh;
  stats(owner).data = h.data;

%% h is a leaf
elseif h.is_leaf
  data = h.data;
  % make cost_table
  cost_table = zeros(K,h.Nh);
  for c=1:K
    id = classes(c).id;

    sub_ct = zeros(1,h.Nh);
    for n=1:h.Nh
      x = data(:,n);
      d = x-classes(c).mc;
      sub_ct(n) = d'*classes(c).A*d + classes(c).a;
    end

    cost_table(c,:) = sub_ct;
  end
  % make stats
  for c=1:K
    stats(c).data = [];
  end
  for n=1:h.Nh
    [cost,c] = min(cost_table(:,n));
    stats(c).data = [stats(c).data data(:,n)];
  end
  for c=1:K
    data_c = stats(c).data;
    [tmp,Nc] = size(data_c);
    stats(c).Nc = Nc;
    if Nc == 0
      stats(c).sum_x = zeros(D,1);
      stats(c).sum_xx = zeros(D);
    else
      stats(c).sum_x = sum(data_c,2);
      stats(c).sum_xx = data_c*data_c';
    end
  end

%% h doesnt have a owner and is not a leaf
else
  [stats_left,hl] = bkm_traverse_tree(h.left,classes,prospectives);
  [stats_right,hr] = bkm_traverse_tree(h.right,classes,prospectives);
  h.left = hl;
  h.right = hr;
  for c=1:K
    stats(c).sum_x = stats_left(c).sum_x + stats_right(c).sum_x;
    stats(c).sum_xx = stats_left(c).sum_xx + stats_right(c).sum_xx;
    stats(c).Nc = stats_left(c).Nc + stats_right(c).Nc;
    stats(c).data = [stats_left(c).data stats_right(c).data];
  end
end
