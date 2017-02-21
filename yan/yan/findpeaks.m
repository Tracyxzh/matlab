function [l,p]=findpeaks(x,L,MAX,excl);
%FINDPEAKS   Finds peaks or valleys of non-negative data
%
% Syntax:
%   [l,p]=findpeaks(x,L,MAX,excl);
%
% About:
%   Warning: This is different from the findpeaks.m file attached in MATALB. 
%
% Input:
%   x        input data (assumed non-negative)
%   L        number of peaks to find (default: all peaks)
%   MAX      search for maximum or minimum ({1,0}) (default: maximum)
%   excl     vector of locations to be excluded (default: empty)
%
% Output:
%   l        location of L largest peaks
%   p        L largest peaks in x
%
% Example:
%   [l,p]=findpeaks(abs(fft(x,8192)),3);
if nargin<4,excl=[];end
if nargin<3,MAX=1;end
if nargin<2,L=length(x);end
x=x(:);
df=diff(x);
if MAX,
    ndx=find(diff(sign(df))<0)+1;
else
    ndx=find(diff(sign(df))>0)+1;
end
if not(isempty(excl)),
    ndx=setdiff(ndx,excl);
end
p=x(ndx);
[sort_p,sort_ndx]=sort(p);
if MAX,
    sort_p=flipud(sort_p);
    sort_ndx=flipud(sort_ndx);
end
p=sort_p(1:min(L,length(p)));
l=ndx(sort_ndx(1:min(L,length(p))));
plot(p)
xlabel('Pixel Value');
ylabel('Number of Pixels');
title('灰度直方图的波峰和波谷')
hold on
plot(l,'*');
hold off
axis tight