%% -*- matlab -*-

% instanciate a conga line data structure.

% cl.S; array of struct class
% cl.sub; array of structs which have N, S and G
% cl.sub(i).S; array of struct class

function cl_new(data,arg);

global cl;

cl.arg = arg;
p1 = arg.p1;
p2 = arg.p2;
p3 = arg.p3;
p4 = arg.p4;
p5 = arg.p5;

[D,N] = size(data);
for n=1:N
  sum_xx_cell{n} = data(:,n)*data(:,n)';
end
F = bkm_Fc_stats(data,sum_xx_cell,ones(1,N),p1,p2,p3,p4,p5);
for n=1:N
%   classes(n) = cl_mkclass(data(:,n),sum_xx_cell{n},1,F(n));
  classes(n) = struct('id',n,'sum_x',data(:,n),'sum_xx', ...
                      sum_xx_cell{n},'Nc',1,'F',F(n));
end
cl.id2class = classes;
cl.available_ids = [N+1];

% fields for cache
cl.dist_table = zeros(N);
cl.merged_F = zeros(N);
% cl.dist_table = zeros(N,N,'single');
% cl.merged_F = zeros(N,N,'single');
% fields for cache --end

for i=1:N-1
  Fi = classes(i).F;
  x = data(:,i);
  sum_xx_cell = [];
  for j=1:N-i
    sum_xx_cell{j} = classes(i).sum_xx + classes(i+j).sum_xx;
  end
  mergedF = bkm_Fc_stats(data(:,i+1:N)+x*ones(1,N-i),sum_xx_cell,2* ...
                         ones(1,N-i),p1,p2,p3,p4,p5);
  dists = mergedF - Fi*ones(1,N-i) - [classes(i+1:N).F];
  cl.dist_table(i,i+1:N) = dists;
  cl.dist_table(i+1:N,i) = dists;
  cl.merged_F(i,i+1:N) = mergedF;
  cl.merged_F(i+1:N,i) = mergedF;
end

cl.S = classes;
cl.sub(1).S = classes;
cl_mkG(1);

