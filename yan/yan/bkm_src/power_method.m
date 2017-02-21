% -*- matlab -*-
function [vec,value]=power_method(A,start,precision)

switch nargin
 case 1
  start = ones(length(A),1);
  precision = 10e-10;
 case 2
  precision = 10e-10;
 case 3
 otherwise
  error 'invalid number of arguments'
end

%
% xp = A^p * x
% x(p+1) = lambda * xp   when p is big enough
% lambda = x(p+1)'*xp / xp'*xp
% 
diff=precision+1;
x=start;
n=norm(x)+diff;
while diff> precision
  y=A*x;
  n2 = norm(x);
  diff=abs(n2-n);
  n=n2;
  x=y/n;
end
vec=x/norm(x);
value=n;

