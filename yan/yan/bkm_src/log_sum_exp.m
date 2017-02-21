function val = log_sum_exp(x,dimension,y);
% function val = log_sum_exp(x,dimension);
% function val = log_sum_exp(x,dimension,y);
%
% val = log( sum( exp(x), dimension ) )
% val = log( sum( exp(x).*y, dimension ) )
%
% x can be -inf but cannot be +inf.

if length(find(real(x)==inf)) > 0
  warning(['x contains inf; x=' num2str(x)])
end
if has_nan(x)
  x
  error('x has NaN(s).')
end

the_other_dimension = -(dimension-1.5)+1.5;
x = permute(x,[dimension,the_other_dimension]);
% now we can do anything as if dimension=1. -> val is a 1xN matrix.
[M,N] = size(x);
max_x = max(real(x),[],1); % 1xN
max_x_m=ones(M,1)*max_x; % MxN
non_neg_inf_indices = find(x~=-inf);
exp_x_minus_max = zeros(M,N);
exp_x_minus_max(non_neg_inf_indices) = exp(x(non_neg_inf_indices) ...
                                           - max_x_m(non_neg_inf_indices));
switch nargin
 case 3
  if has_nan(y)
    y
    error('y has NaN(s).')
  end
  y = permute(y,[dimension,the_other_dimension]);
  if ~isequal(size(x),size(y))
    error('size(x) and size(y) must be equal.');
  end
%   exp_x_minus_max
%   y
  arg_of_log = sum(exp_x_minus_max.*y,1);
 
 case 2
  arg_of_log = sum(exp_x_minus_max,1);
 
 otherwise
  error('invalid #arguments.')
end

val = max_x + log_no_w(arg_of_log);

val = permute(val,[dimension,the_other_dimension]);
if has_nan(val)
  val
  max_x
  log_no_w_arg_of_log = log_no_w(arg_of_log)
  error('log_sum_exp returns NaN(s).')
end


% Local Variables: ***
% mode: matlab ***
% End: ***
