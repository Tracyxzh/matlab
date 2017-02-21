function thirdmoment = thirdmoment( inputImg, m )
%thirdmoment 三阶矩
%   此处显示详细说明

% 求图象大小
[rows, columns] = size(inputImg);

% 初始化
thirdmoment = 0;

% 循环处理
for r = 1 : rows
    for c = 1 : columns
        thirdmoment = thirdmoment + (inputImg(r,c) - m) ^ 3;
    end
end
        
end

