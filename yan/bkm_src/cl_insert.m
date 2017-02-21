%% -*- matlab -*-

function cl_insert(class);

global cl;

k = length(cl.sub);
cl.S = [cl.S class];
cl.sub(k+1).S = class;
% cl_mkG(k+1);

% ---- from cl_mkG.m
S = cl.S;
Si = cl.sub(k+1).S;
p1.class = Si;
p1.distFromPrev = inf;
SIDs = [S.id];

index = find(SIDs==class.id,1,'first');
SmP_ID = SIDs;
SmP_ID(index) = [];

distance = cl.dist_table(class.id,SmP_ID);
[min_dist,min_i] = min(distance);
p2.distFromPrev = min_dist;
p2.class = cl.id2class(SmP_ID(min_i));
cl.sub(k+1).G.path = [p1 p2];
cl.sub(k+1).lenOfG = 2;
