%% -*- matlab -*-
% Bayesian K-means; bottom-up 

function K = bkm_bucl(data);
global cl;
cl = [];

[D,N] = size(data);
K = N;

S = eye(D);
b0r = 0.01*bkm_b0r(data,S);

mode = 2;

xi = 0.01;
[p1,p2,p3,p4,p5,p6] = bkm_prior_hyps(mode,data,xi,b0r,S);

arg.p1 = p1;
arg.p2 = p2;
arg.p3 = p3;
arg.p4 = p4;
arg.p5 = p5;
cl_new(data,arg);
% cl_disp(cl);
% cl.dist_table

estimated_K = N;
loop = 0;
min_Free = inf;
while 1
  K = length(cl.S);

  term_K = bkm_term_K(N,K,mode,p6);
  F = sum([cl.S.F]) + term_K;
  if F < min_Free
    estimated_K = K;
    min_Free = F;
  end
  disp(['K=' num2str(K) '; F=' num2str(F) '; Nc=' num2str([cl.S(:).Nc])])

  if K == 1
    break
  end

  [c1,c2,min_dist] = cl_find_nn(cl);
%   disp(['[i,j]=' num2str([c1.id,c2.id]) '; min_dist=' num2str(min_dist) ...
%         '; ids=' num2str([cl.S(:).id])])
  new_term_K = bkm_term_K(N,K-1,mode,p6);

  cl_delete(c1.id);
%   disp 'DELETED c1'
%   cl_disp(cl);
  cl_delete(c2.id);
%   disp 'DELETED c2'
%   cl_disp(cl);
  % merge;
  merged_class = cl_mkclass(c1.sum_x+c2.sum_x,c1.sum_xx+ ...
                            c2.sum_xx,c1.Nc+c2.Nc,cl.merged_F(c1.id,c2.id));
  cl_insert(merged_class);
%   disp 'INSERTED new'
%   cl_disp(cl);
%   cl.dist_table

  loop = loop + 1;
end

K = estimated_K;
