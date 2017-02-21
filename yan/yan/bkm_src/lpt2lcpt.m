function lcpt=lpt2lcpt(lpt,dimension);
% function lcpt=lpt2lcpt(lpt,dimension);
%
% make a log conditional probability table with log probability table
%
% lpt is a matrix.
% dimension must be either 1 or 2.
%
% lcpt = log( exp(lpt) / sum(exp(lpt)) )
%      = lpt - log(sum(exp(lpt)))
%

the_other_dimension=-(dimension-1.5)+1.5;
lpt=permute(lpt,[dimension,the_other_dimension]);
% now we can calculate as if dimension=1.

log_sum_exp_lpt = log_sum_exp(lpt,2); % Mx1
lcpt = lpt - log_sum_exp_lpt*ones(1,size(lpt,2));

lcpt=permute(lcpt,[dimension,the_other_dimension]);

% Local Variables: ***
% mode: matlab ***
% End: ***
