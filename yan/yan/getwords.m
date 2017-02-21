function [ a, b ] = getwords( inputImg )
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

figure;
a = findpeaks(rowhist,10,10,0);
figure;
b = findpeaks(columnhist,10,10,0);
end

