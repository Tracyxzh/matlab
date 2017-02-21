% -*- matlab -*-

function h = mkkdtree(data,leafMaxN);

global mkkdtree_last_id;
if isempty(mkkdtree_last_id)
  mkkdtree_last_id = 0;
end

[D,N] = size(data);
h.Nh = N;
h.lb = min(data,[],2);
h.ub = max(data,[],2);
if D <= 8 % 8 must be the same as the dimension used in
          % bkm_owner_maxdist.m
  h.corners = bkm_kd_mkcorners(h.lb,h.ub,1);
end
mkkdtree_last_id = mkkdtree_last_id + 1;
h.id = mkkdtree_last_id;

if N <= leafMaxN
  h.is_leaf = 1;
  
  h.data = data;
  h.sum_x = sum(data,2);
  h.sum_xx = data*data';
  h.mean_x = h.sum_x / N;
else
  h.is_leaf = 0;

  diff = h.ub - h.lb;
  [tmp,split_dim] = max(diff);
  h.split_dim = split_dim;
  split_val = h.lb(split_dim) + diff(split_dim)*0.5;
  h.split_val = split_val;

  data_left = [];
  data_right = [];
  for n=1:N
    x = data(:,n);
    if x(split_dim) < split_val
      data_left = [data_left x];
    else
      data_right = [data_right x];
    end
  end
  h.left = mkkdtree(data_left,leafMaxN);
  h.right = mkkdtree(data_right,leafMaxN);

  h.data = [h.left.data h.right.data];
  h.sum_x = h.left.sum_x + h.right.sum_x;
  h.sum_xx = h.left.sum_xx + h.right.sum_xx;
  h.mean_x = h.sum_x / N;
end

% cache
h.maxdist_cached = [];
