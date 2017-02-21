function val=vector_cosine(v1,v2);
% v1 and v2 must be Dx1 matrices (vectors).
%
if size(v1,1)~=size(v2,1) || size(v1,2)~=1 || size(v2,2)~=1
  error(['invalid argument.   size(v1)=' num2str(size(v1)) ...
         ',   size(v2)=' num2str(size(v2))])
end
val=v1'*v2/(norm(v1)*norm(v2));

% Local Variables: ***
% mode: matlab ***
% End: ***
