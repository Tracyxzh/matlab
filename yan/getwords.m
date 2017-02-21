function [ rcutp, ccutp ] = getwords( inputImg )
%getwords 获取单独的字
%   通过行列的投影，找到分割点，分割字符
inputImg = ~inputImg;
%% 求图象大小
[rows, columns] = size(inputImg);

%% 初始化
rowhist = ones(1, rows); % 存储每行为黑的个数
columnhist = ones(1, columns);

%% 循环计算
for c = 1 : columns % 先分割列
    columnhist(1, c) = sum(inputImg(:, c));
end

for r = 1 : rows % 再分割列
    rowhist(1, r) = sum(inputImg(r, :));
end

%% 找到分割点
% 初始化
T = 10;
rcutp = []; % 存储分割点
ccutp = [];
for c = 10 : columns - 10 % 行分割点
    if columnhist(1, c) > T
        rcutp = [rcutp c];
    end
end

for r = 10 : rows - 10 % 列分割点
    if rowhist(1, r) > T
        ccutp = [ccutp c];
    end
end
a = bkm_sm(rowhist);
b = bkm_sm(columnhist);
figure;
bar(rowhist);
figure;
bar(columnhist);
end

