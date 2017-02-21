%% -*- matlab -*-

function b0r = bkm_b0r(data,S);

[D,N] = size(data);

std_dist = sqrt(trace(S));

% [s,indices] = sort(rand(1,N));
% dists = [];
% for i=1:ceil(N*0.1)
%   index = indices(i);
%   diff = data(:,[1:index-1 index+1:N]) - data(:,index)*ones(1,N-1);
%   dists = [dists sqrt(sum(diff.*diff,1))];
% end
% sorted_dists = sort(dists);
% mean_min_d = mean(sorted_dists(1:3));

A = ceil(rand(2,floor(N*0.1))*(N-1));
for i=1:floor(N*0.1)
  j = floor(N*0.1)+1-i;
  if A(1,j) == A(2,j)
    A(:,j) = [];
  end
end
dists = [];
[tmp,len] = size(A);
min_d = inf;
for i=1:len
  diff = data(:,A(1,i))-data(:,A(2,i));
  dist = sqrt(diff'*diff);
  dists = [dists dist];
end
dists_sorted = sort(dists);
mean_min_d = mean(dists_sorted(1:min([3 length(dists_sorted)])));
% mean_min_d

b0r = (mean_min_d/std_dist)^2;

%% true min
% min_d = inf;
% for i=2:N-1
%   for j=i+1:N
%     diff = data(:,i)-data(:,j);
%     dist = sqrt(diff'*diff);
%     if dist < min_d
%       min_d = dist;
%     end
%   end
% end
% min_d

% true_b0r = (min_d/std_dist)^2
