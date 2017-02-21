%% -*- matlab -*-

function [class1,class2,min_dist] = cl_find_nn(cl);

Gs = [cl.sub(:).G];
paths = [Gs(:).path];
dists = [paths(:).distFromPrev];
[min_dist,min_i] = min(dists);
class1 = paths(min_i-1).class;
class2 = paths(min_i).class;
