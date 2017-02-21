% -*- matlab -*-

% divide data into two classes using Euclid norm.

function [class1,class2,A] = km_split(data);

[D,N] = size(data);

[v,l] = eig( cov(data') );
[max_val,max_index] = max(diag(l));

diff = v(:,max_index)*sqrt(l(max_index,max_index));
center = mean(data,2);
center1 = center + diff;
center2 = center - diff;

class1 = [];
class2 = [];
A = zeros(N,2);
for n=1:N
  x = data(:,n);
  if norm(center1-x) < norm(center2-x)
    class1 = [class1 x];
    A(n,1) = 1;
  else
    class2 = [class2 x];
    A(n,2) = 1;
  end
end
