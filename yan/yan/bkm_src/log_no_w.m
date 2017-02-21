function val = log_no_w( x );
% function val = log_no_w( x );
%
% val = log(x)
%
% log_no_w does not warn anything.

non_zero_indices = find(x~=0);
val = ones(size(x))*(-inf);
val(non_zero_indices) = log(x(non_zero_indices));


% Local Variables: ***
% mode: matlab ***
% End: ***
