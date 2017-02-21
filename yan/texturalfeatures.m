function texfeature= texturalfeatures( inputImg )
%texfeature 获得纹理特征
%   获得纹理特征

%% 求解均值和方差、平滑度
mean = mean2(inputImg); %均值
std = std2(inputImg); %方差
somthness = 1 - 1 / (1 + std^2); %平滑度

%% 求解灰度概率直方图
histim = imhist(inputImg); %计算直方图
columns = size(histim, 1); 
% 初始化
phistim = zeros(1, columns);
sumhist = sum(histim);
% 灰度概率直方图
for c = 1 : columns
    phistim(c) = histim(c) / sumhist;
end
%% 三阶矩
skewness = 0;
for c = 1 : columns
    skewness = skewness + (c - mean) * phistim(c);
end

%% 一致性
uniform = 0;
for c = 1 : columns
    uniform = uniform + phistim(c) ^ 2;
end

%% 能量
energe = 0;
for c = 1 : columns
    energe = energe + phistim(c) * log2(phistim(c));
end

texfeature = [mean,std,somthness,skewness,uniform,energe];
end

