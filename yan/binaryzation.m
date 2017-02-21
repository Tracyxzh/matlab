function imgInput = binaryzation( imgInput )
%binaryzation
%   迭代二值化

imgInput = double(imgInput);
% 求图象大小
[row, column] = size(imgInput);

% 预先指定范围
set  = 1;

% 选择初始阈值
oldThreShold = max(max(imgInput)) - min(min(imgInput));
newThreShold = 0;
disThreShold = abs(newThreShold - oldThreShold);

% 计算大于阈值的灰度总值和小于阈值的灰度总值
sumUp = 0; nUp = 0;
sumDown = 0; nDown = 0;

% 阈值迭代
while disThreShold >= set
    for r = 1 : row
        for c = 1: column
            if imgInput(r, c) >= oldThreShold
                sumUp = sumUp + imgInput(r, c);
                nUp = nUp + 1;
            else
                sumDown = sumDown + imgInput(r, c);
                nDown = nDown + 1;
            end
        end
    end
    % 计算新的阈值
    newThreShold = (sumUp / nUp + sumDown / nDown) / 2;
    disThreShold = abs(newThreShold - oldThreShold);
    oldThreShold = newThreShold;
end
% 对图像二值化处理
for r = 1 : row
    for c = 1 : column
        if imgInput(r, c) >= newThreShold;
            imgInput(r, c) = 1;
        else
            imgInput(r, c) = 0;
        end
    end
end
end

