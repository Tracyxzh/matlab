%% -*- matlab -*-
% Bayesian K-means; split and merge
%
% data: double array DxN where D is the dimension and N is the
% number of datapoints.
function [K,clusters,data] = bkm_sm(data,use_kdtree);
  
THRESHOLD = 1.0e-8;
  
switch nargin
 case 1 % up to use_kdtree
  use_kdtree = 1;
 case 2
  use_kdtree; % to be valid for octave's syntax
 otherwise
  error( 'invalid number of arguments' );
end

strategy = 'sm';
strategy_len = size(strategy,2);

mode=2;
[D,N] = size(data);

S = cov(data');
b0r = bkm_b0r(data,S)

xi = 0.1;
[p1,p2,p3,p4,p5,p6] = bkm_prior_hyps(mode,data,xi,b0r,S);
mu0 = p1;
eta0 = p2;
B0 = p3;

if use_kdtree
  kdtree = mkkdtree(data,1000);
else
  kdtree = [];
end

% % step 1;
K = 1;
classes(1) = bkm_mkclass(data,xi,p1,p2,p3,p4);
F = [bkm_Fc_stats(classes.sum_x,{classes.sum_xx},classes.Nc,p1,p2,p3,p4,p5)];
total_F = sum(F) + bkm_term_K(N,K,mode,p6);

total_F
Ncs = [classes(:).Nc]

while 1
  % step 2; sort candidates
  log_p_of_xn_given_c = zeros(K,N);
  for c=1:K
    Nc = classes(c).Nc;
    Xbarc = classes(c).sum_x/Nc;
    Sc = classes(c).sum_xx - Nc*Xbarc*Xbarc';
    NcpXi = Nc+xi;
    mc = (Nc*Xbarc+xi*mu0) / (NcpXi);
    etac = eta0 + Nc;
    d = Xbarc - mu0;
    Bc = B0 + Sc + Nc*xi/(NcpXi)*d*d';
    detBc = det(Bc);
    log_p_of_xn_given_c(c,:) = log_normal_dist(data,mc,inv(Bc)*etac); % KxN
  end
  log_p_of_c_xn = log([classes(:).Nc]/N)'*ones(1,N) + log_p_of_xn_given_c; % KxN
  log_p_of_c_given_xn = lpt2lcpt(log_p_of_c_xn,2); % KxN
  p_of_c_given_xn=exp(log_p_of_c_given_xn); % KxN
  candidates_merge = [];
  for i=1:K-1
    for j=i+1:K
      v1=p_of_c_given_xn(i,:)'; % Nx1
      v2=p_of_c_given_xn(j,:)'; % Nx1
      candidates_merge = [candidates_merge; [i j vector_cosine(v1,v2)]];
    end
  end
  if ~isempty(candidates_merge)
    candidates_merge = sortrows(candidates_merge,-3)';
    candidates_merge(3,:) = [];
  end
  candidates_split = [1:K; zeros(1,K)]; % 2xK
  candidates_split(2,:) = jsplit(log_p_of_c_given_xn,log_p_of_xn_given_c);
  candidates_split = sortrows(candidates_split',-2)';
  candidates_split(2,:) = [];

  % step 3; merge; merge and split; split
  new_classes = classes;
  new_total_F = total_F;
  for strategy_index = 1:strategy_len
    switch strategy(strategy_index)
     case 'm'
      % 3.1 merge
      disp('merge')
      new_total_F = total_F;
      for c=1:min(10,size(candidates_merge,2))
        i = candidates_merge(1,c); % i must be less than j
        j = candidates_merge(2,c);
        tmp_classes = classes;
        tmp_classes(i) = bkm_mkclass([classes(i).data,classes(j).data], ...
                                   xi,p1,p2,p3,p4);
        tmp_classes = tmp_classes([1:j-1 j+1:K]);
        [tmp_classes tmp_F kdtree] = bkm_km(0,tmp_classes,mode,xi,p1, ...
                                          p2,p3,p4,use_kdtree,kdtree);
        tmp_K = length(tmp_F);
        tmp_total_F = sum(tmp_F) + bkm_term_K(N,tmp_K,mode,p6);
        diff = tmp_total_F - total_F;
        if diff<0 & abs(diff/total_F) > THRESHOLD
          new_classes = tmp_classes;
          new_total_F = tmp_total_F;
          procedure = 'do merge';
          break
        end
      end
      diff = new_total_F - total_F;
      if diff<0 & abs(diff/total_F) > THRESHOLD
        break
      end
      
     case 's'
      % 3.2 split
      disp('split')
      for c=1:min(10,length(candidates_split))
        i = candidates_split(c);
        if classes(i).Nc <= 1
          continue
        end
        data_i = classes(i).data;
        [data1, data2] = km_split(data_i);
        tmp_classes = classes;
        tmp_classes(i) = bkm_mkclass(data1,xi,p1,p2,p3,p4);
        tmp_classes(K+1) = bkm_mkclass(data2,xi,p1,p2,p3,p4);
        [tmp_classes tmp_F kdtree] = bkm_km(0,tmp_classes,mode,xi,p1, ...
                                          p2,p3,p4,use_kdtree,kdtree);
        tmp_K = length(tmp_F);
        tmp_total_F = sum(tmp_F) + bkm_term_K(N,tmp_K,mode,p6);
        diff = tmp_total_F - total_F;
        if diff<0 & abs(diff/total_F) > THRESHOLD
          if tmp_total_F < new_total_F
            new_classes = tmp_classes;
            new_total_F = tmp_total_F;
            procedure = 'do split';
          end
          break
        end
      end
      diff = new_total_F - total_F;
      if diff<0 & abs(diff/total_F) > THRESHOLD
        break
      end
    
    end % switch
  end % for strategy_index = 1:size(strategy_index)

  % initially, new_total_F was total_F
  % so, check if new_total_F is lower than total_F
  if new_total_F >= total_F
    disp('done')
    break
  else
    disp(procedure)
  end

  total_F = new_total_F;
  classes = new_classes;
  K = length(classes);
  
  new_total_F
  Ncs = [classes(:).Nc]

end % while 1

for c=1:length(classes)
  clusters{c}=classes(c).data;
end

total_F
Ncs = [classes(:).Nc]
