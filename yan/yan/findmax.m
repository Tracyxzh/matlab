function [output_peak] = findmax(h,mpd,windowSize,refine)

if nargin < 2
%minimum peak distance
mpd = 10;
%smoothing windowSize
windowSize = 5;
%Local minima refine
refine = 0;
end

%threshold is set at least 
thresh = size(h,1)*size(h,2)*0.01;

% %Find the histogram
% h = imhist(I);
% imshow(I)
%Smooth the histogram to remove local variations
h1 = filter(ones(1,windowSize)/windowSize,1,h);

d = diff(h1);

sign_previous = [0;];
sign = zeros(255,1);

for i = 1:255
    if(d(i) ~= 0)
        sign(i,1) = d(i)/abs(d(i));
    else
        sign(i,1) = 0;
    end
end

sign_previous = [sign_previous ; sign];

%Find peaks with a minimum peakdistance of a given value

% Find peaks
p_pos = 0;
p_neg = 0;
pnum = 0;
for i=2:256
    if sign_previous(i)<sign_previous(i-1)
        if sign_previous(i) == 0
            p_pos = i-1;
        else if sign_previous(i)<0 && sign_previous(i-1)==0
                p_neg = i-1;
                pnum = pnum+1;
                locs(pnum) = round((p_pos+p_neg)/2);
            else
                pnum=pnum+1;
                locs(pnum)=i-1;
             end
        end
    end
end

peak = zeros(size(locs,2),1);
minima_low = zeros(size(locs,2),1);
minima_high = zeros(size(locs,2),1);
area = zeros(size(locs,2),1);

for i = 1:size(locs,2)
    peak(i) = locs(i);
end

%Find Local minima
num = 1;
lmin = [];

for i=2:256
    if sign_previous(i)>sign_previous(i-1)
        lmin(num)=i-1;
        num=num+1;
    end
end

%find local minima_low and minima_high
for i = 1:size(locs,2)
    ind_min = find(lmin-locs(i)<0);
    ind_max = find(lmin-locs(i)>0);
    
    size_min = size(ind_min,2);
    size_max = size(ind_max,2);
    
    minima_low(i) = 1;
    minima_high(i) = 255;

    if size_min>=1
        minima_low(i) = lmin(ind_min(size_min));
    end

    if size_max>=1
        minima_high(i) = lmin(ind_max(1));
    end
end

% refine local minima
if refine>0
    for i = 1:size(locs,2)-1
        if(minima_high(i)< minima_low(i+1))
        if( minima_high(i)~=minima_low(i+1) && min(h1(minima_high(i):minima_low(i+1))>0) )
            minima = floor((minima_high(i)+ minima_low(i+1))/2);
            minima_low(i+1) = minima;
            minima_high(i) = minima;
        end
        end
    end
end
   
num = 0;
outpeak = 0;

%refine peaks based on area threshold & mpd
for i = 1:size(locs,2)
    area(i) = sum(h1(minima_low(i):minima_high(i)));
    if outpeak >= 1
        if area(i)>thresh 
            if locs(i)-locs(outpeak)>mpd
                num = num+1;
                outpeak = i;
                output_peak(num) = peak(i);
                output_minima_low(num) = minima_low(i);
                output_minima_high(num) = minima_high(i);
                
            else
                if area(i)>area(outpeak) 
                    outpeak = i;
                    output_peak(num) = peak(i);
                    %output_minima_low(num) = minima_low(i);
                    output_minima_high(num) = minima_high(i); 
                else
                    output_minima_high(num) = minima_high(i);
                end
            end
        end
    else
        if area(i)>thresh
            num = num+1;
            outpeak = i;
            output_peak(num) = peak(i);
            output_minima_low(num) = minima_low(i);
            output_minima_high(num) = minima_high(i);
        end
    end
end


plot(h1)
xlabel('Pixel Value');
ylabel('Number of Pixels');
title('灰度直方图的波峰和波谷')
hold on
plot(output_peak,h1(output_peak),'*');
plot(output_minima_low,h1(output_minima_low),'or');
plot(output_minima_high,h1(output_minima_high),'or');
hold off
axis tight

end