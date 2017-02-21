function Y = detln( X )
% Y = logdet( X )
% return a log determinant of X

[d err] = chol(X);
if err ~= 0 % err occurs when X is not positive-defenite
  if det(X) == 0
    Y = -inf;
  else
    det(X)
    log(det(X))
    error('error in Choleski disposition for logdet')
%     Y = log(det(X));
  end
else
  d = diag(d);
  Y = sum( log(d) ) *2;
end

%%%%%% Local Variables: *****
%%%%%% mode: matlab *****
%%%%%% End: *****
