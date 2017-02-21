function bool = has_nan(x);
% function bool = has_nan(x);
%
% bool = 0 if x has nan elements.
%      = 1 otherwise.

bool = length(find(isnan(x)==1)) > 0;


% Local Variables: ***
% mode: matlab ***
% End: ***
