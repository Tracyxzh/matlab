%% -*- matlab -*-

% instanciate a conga line data structure.

function class = cl_mkclass(sum_x,sum_xx,Nc,F);

global cl;

class.id = cl.available_ids(1);
if length(cl.available_ids) == 1
  cl.available_ids = cl.available_ids+1;
else
  cl.available_ids(1) = [];
end

class.sum_x = sum_x;
class.sum_xx = sum_xx;
class.Nc = Nc;
class.F = F;
cl.id2class(class.id) = class;

if isfield(cl,'S')
  arg = cl.arg;
  p1 = arg.p1;
  p2 = arg.p2;
  p3 = arg.p3;
  p4 = arg.p4;
  p5 = arg.p5;
  
  k = length(cl.S);
  if k>=1
    for i=1:k
      sum_xx_cell{i} = cl.S(i).sum_xx + sum_xx;
    end
    mergedFs = bkm_Fc_stats([cl.S(:).sum_x]+sum_x*ones(1,k), sum_xx_cell, ...
                            [cl.S(:).Nc]+Nc*ones(1,k), p1,p2,p3,p4,p5);
    ids = [cl.S(:).id];
    Fs = [cl.S(:).F];
    dist = mergedFs - Fs - ones(1,k)*class.F;
    cl.dist_table(ids,class.id) = dist;
    cl.dist_table(class.id,ids) = dist;
    cl.merged_F(ids,class.id) = mergedFs;
    cl.merged_F(class.id,ids) = mergedFs;
  end
end
