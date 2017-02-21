%% -*- matlab -*-

function cl_delete(id);

global cl;

ids = [cl.S(:).id];
cl.S(find(ids==id,1)) = [];
% cl.dist_table(id,:) = inf; % this is useful for debugging.
% cl.dist_table(:,id) = inf;

prevs = []; % array of classes
for i=length(cl.sub):-1:1 % each sub
  % remove id from sub.S
  ids = [cl.sub(i).S(:).id];
  cl.sub(i).S(find(ids==id,1)) = [];
  % remove id from the paths
  for k=length(cl.sub(i).G):-1:1 % each path
    classesInPath = [cl.sub(i).G(k).path(:).class];
    ids = [classesInPath(:).id];
    index = find(ids==id,1); % the length must be 0 or 1.
    if ~isempty(index)
      j = index;
      if j > 1
        prev = cl.sub(i).G(k).path(j-1).class;
        prev_index = find([cl.sub(i).S(:).id]==prev.id,1);
        cl.sub(i).S(prev_index) = []; % it is ok even if prev_index is empty.
        prevs = [prevs prev];
      end
      len_path = length(cl.sub(i).G(k).path);
      % a path will be divided in to `head' and `tail'.
      if j > 3 % head is longer or equal to 3.
        if len_path-j >= 2 % tail is longer or equal to 2.
          tail = cl.sub(i).G(k).path(j+1:len_path);
          tail(1).distFromPrev = inf;
          cl.sub(i).G(length(cl.sub(i).G)+1).path = tail;
        end
        % prev is not needed either because prev will be used in a
        % new partision Si.
        cl.sub(i).G(k).path(j-1:len_path) = [];
      elseif len_path-j >= 2 % tail is longer or equal to 2.
        cl.sub(i).G(k).path(1:j) = [];
        cl.sub(i).G(k).path(1).distFromPrev = inf;
      else
        cl.sub(i).G(k) = [];
      end
    end
  end
  if isempty(cl.sub(i).G)
    cl.sub(i) = [];
  end
end

if ~isempty(prevs)
  k = length(cl.sub);
  cl.sub(k+1).S = cl_uniq_classes(prevs);
  cl_mkG(k+1);
end

% for saving memory
dummy_class.id = 0;
dummy_class.sum_x = [];
dummy_class.sum_xx = [];
dummy_class.Nc = 0;
dummy_class.F = inf;
cl.id2class(id) = dummy_class;

index = find(cl.available_ids>id,1);
cl.available_ids = [cl.available_ids(1:index-1) id ...
                    cl.available_ids(index:length(cl.available_ids))];
