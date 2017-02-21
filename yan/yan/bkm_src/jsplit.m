function scores=jsplit(log_p_of_c_given_xn,log_p_of_xn_given_c);
% log_p_of_c_given_xn and log_p_of_xn_given_c are KxN matrices.
% scores is a Kx1 matrix.

N=size(log_p_of_xn_given_c,2);
p_of_c_given_xn = exp(log_p_of_xn_given_c);
sum_n_p_of_c_given_xn=sum(p_of_c_given_xn,2); % Kx1
scores=sum(p_of_c_given_xn./(sum_n_p_of_c_given_xn*ones(1,N)) ...
           .*(log_p_of_c_given_xn-log(sum_n_p_of_c_given_xn*ones(1,N)) ...
              -log_p_of_xn_given_c),2); % Kx1


% Local Variables: ***
% mode: matlab ***
% End: ***
