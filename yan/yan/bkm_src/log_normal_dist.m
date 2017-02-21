function log_prob = log_normal_dist(x,nu,prec)
% x must be a D by n matrix where D is the dimension and n is #datapoints.
% nu must be a D by 1 matrix
% prec must be a D by D matrix or a scalar.
% prob will be a D by n matrix.

[D,N] = size(x);

d = x - nu*ones(1,N);
det_prec = det(prec);
% if det_prec==0
%   error('det(prec)==0');
% end
log_prob = (-D*0.5)*log(2*pi)+0.5*log(det_prec)-0.5*sum(d.*(prec*d),1);

%%%%%% Local Variables: *****
%%%%%% mode: matlab *****
%%%%%% End: *****
