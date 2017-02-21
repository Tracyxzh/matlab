% -*- matlab -*-

% h: a node of a kd-tree
% prospectives: indices of classes; 1 <= prospectives(i) <= K
% return: 1 < owner < K -> success
%         owner == 0 -> failure
function [owner,prospectives,h] = bkm_owner(h,classes,prospectives);

mcs = [classes.mc];
[D,K] = size(mcs);

% ignore some cases
if length(find(sum((h.lb*ones(1,K)<mcs).*(mcs<h.ub*ones(1,K)),1)==D)) >= 2
  owner = 0;
  return
end

min_points = zeros(D,length(prospectives));
for i=1:length(prospectives)
  c = prospectives(i);
  mc = classes(c).mc;
  d1 = h.lb-mc;
  d2 = h.ub-mc;
  vec = d2;
  indices = find(mc<h.lb);
  vec(indices)=d1(indices);
  indices = find((h.lb<=mc) & (mc<=h.ub));
  vec(indices)=0;
  min_points(:,i) = vec;
end
costs_sub = [classes(prospectives).lambda_min].*sum(min_points.*min_points,1) ...
    + [classes(prospectives).a];
costs = inf(1,K);
costs(prospectives) = costs_sub;
% length(costs) must be K because costs is used below.

[cost,owner_candidate] = min(costs);
maxdist = bkm_owner_maxdist(h,classes,owner_candidate);
indices = find(costs>maxdist);
prospectives_flag = zeros(1,K);
prospectives_flag(prospectives) = 1;
prospectives_flag(indices) = 0;
prospectives = find(prospectives_flag==1);
if length(prospectives) == 1
  owner = owner_candidate;
else
  owner = 0;
end
