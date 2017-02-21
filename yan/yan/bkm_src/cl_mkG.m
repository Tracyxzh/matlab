%% -*- matlab -*-

function cl_mkG(i);

global cl;

S = cl.S;
Si = cl.sub(i).S;
SIDs = [S.id];
SiIDs = [Si.id];
tmp(SIDs) = 0;
idlen = length(tmp);

zeros_idlen = zeros(1,idlen);
Sid2exist = zeros_idlen;
Sid2exist(SIDs) = 1;
Siid2exist = zeros_idlen;
Siid2exist(SiIDs) = 1;
pathID2exist = zeros_idlen;

lastClass = Si(1);
min_dist = inf;
path = [];


while 1
  p.class = lastClass;
  p.distFromPrev = min_dist;
  path = [path p];
  pathID2exist(lastClass.id) = 1;

  if Siid2exist(lastClass.id)
    ObjS = S;
    ObjIDs = SIDs;
    ObjID2exist = Sid2exist;
  else
    ObjS = Si;
    ObjIDs = SiIDs;
    ObjID2exist = Siid2exist;
  end

  SmP_ID = find((ObjID2exist-pathID2exist)==1);
  if isempty(SmP_ID)
    break
  end
  distance = cl.dist_table(lastClass.id,SmP_ID);
  [min_dist,min_i] = min(distance);
  lastClass = cl.id2class(SmP_ID(min_i));
end

cl.sub(i).G(1).path = path;
cl.sub(i).lenOfG = length(path);
