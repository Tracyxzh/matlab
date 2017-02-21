%% -*- matlab -*-
% Bayesian K-means; bottom-up 
%
% data: double array DxN where D is the dimension and N is the
% number of datapoints.
function [Z,K] = bkm_bu(data,use_cl);

[D,N] = size(data);

if nargin == 1
  use_cl = 1;
end
if use_cl
  K = bkm_bucl(data);
  Z = zeros(N-1,3);
  return
end

S = eye(D);
b0r = 0.01*bkm_b0r(data,S);

xi = 0.01;
mode = 2;
[p1,p2,p3,p4,p5,p6] = bkm_prior_hyps(mode,data,xi,b0r,S);
global cl
cl = [];
arg.p1 = p1;
arg.p2 = p2;
arg.p3 = p3;
arg.p4 = p4;
arg.p5 = p5;
cl.arg = arg;
cl.available_ids = [1];

for n=1:N
  sum_xx_cell{n} = data(:,n)*data(:,n)';
end
Free = bkm_Fc_stats(data,sum_xx_cell,ones(1,N),p1,p2,p3,p4,p5);
Z=zeros(N-1,3);
for i= 1:N
  classes(i) = cl_mkclass(data(:,i),sum_xx_cell{i},1,Free(i));
end
K = N;

% DF(i,j) represents F({i,j}) - F(i) - F(j)
DF = zeros(K,K);
init = 1;
update_i = -1;


estimated_K = N;
loop = 0;
min_Free = inf;
while 1
  K = length(classes);
  
  term_K = bkm_term_K(N,K,mode,p6);
  Free = sum([classes(:).F]) + term_K;
  if Free < min_Free
    estimated_K = K;
    min_Free = Free;
  end
  disp(['K=' num2str(K) '; F=' num2str(Free) '; Nc=' num2str([classes(:).Nc])])
  
  if K == 1
    break
  end
  
  if init == 1
    init = 0;
    for i = 1:K-1;
      Fi = classes(i).F;

      sum_xx_cell = [];
      for j=1:K-i
        sum_xx_cell{j} = classes(i).sum_xx + classes(i+j).sum_xx;
      end
      sum_x = [classes(i+1:K).sum_x]+classes(i).sum_x*ones(1,K-i);
      Nc = [classes(i+1:K).Nc]+classes(i).Nc*ones(1,K-i);
      mergedF = bkm_Fc_stats(sum_x,sum_xx_cell,Nc,p1,p2,p3,p4,p5);
      diff = mergedF - Fi*ones(1,K-i) - [classes(i+1:K).F];
      DF(i,i+1:K) = diff;
    end
  else
    for i = update_i
      Fi = classes(i).F;
      sum_xx_cell = [];
      for j=1:i-1
        sum_xx_cell{j} = classes(i).sum_xx + classes(j).sum_xx;
      end
      for j=i+1:K
        sum_xx_cell{j-1} = classes(i).sum_xx + classes(j).sum_xx;
      end
      sum_x = [classes([1:i-1 i+1:K]).sum_x]+classes(i).sum_x*ones(1,K-1);
      Nc = [classes([1:i-1 i+1:K]).Nc]+classes(i).Nc*ones(1,K-1);
      mergedF = bkm_Fc_stats(sum_x,sum_xx_cell,Nc,p1,p2,p3,p4,p5);
      diff = mergedF - Fi*ones(1,K-1) - [classes([1:i-1 i+1:K]).F];
      DF(1:i-1,i) = diff(1:i-1);
      DF(i,i+1:K) = diff(i:K-1);
    end
  end
%   DF
  min_df_i = 0;
  min_df_j = 0;
  min_df = inf;
  for i = 1:K-1;
    for j = i+1:K;
      if DF(i,j) < min_df;
        min_df_i = i;
        min_df_j = j;
        min_df = DF(i,j);
      end
    end
  end
%   disp(['[i,j]=' num2str([min_df_i min_df_j]) '; min_df=' num2str(min_df)])
  K = length(classes);
  term_K = bkm_term_K(N,K,mode,p6);
  new_term_K = bkm_term_K(N,K-1,mode,p6);
  if nargout==1 & min_df+new_term_K-term_K > 0 | min_df == inf
    Free = sum([classes(:).F]) + term_K;
    break
  end
  c1 = classes(min_df_i);
  c2 = classes(min_df_j);
  sum_x = c1.sum_x+c2.sum_x;
  sum_xx = c1.sum_xx+c2.sum_xx;
  Nc = c1.Nc+c2.Nc;
  classes(min_df_i) = cl_mkclass(sum_x,sum_xx,Nc, ...
                                 bkm_Fc_stats(sum_x,{sum_xx},Nc, ...
                                              p1,p2,p3,p4,p5));
  Z(classes(min_df_i).id-N,1)=c1.id;
  Z(classes(min_df_i).id-N,2)=c2.id;
  Z(classes(min_df_i).id-N,3)=min_df;
  classes(min_df_j) = [];
  DF(:,min_df_j) = [];
  DF(min_df_j,:) = [];
  update_i = min_df_i;
  loop = loop + 1;
end

K = estimated_K;
