function a = directionfeatures( inputImg )
%directionfeature 方向特征
%   方向0，1，2，3，7上的数目

% 求图象大小
[rows, columns] = size(inputImg);

% 各个方向初始化
dir10 = 0; dir11 = 0; dir12 = 0; dir13 = 0; dir17 = 0;
dir20 = 0; dir21 = 0; dir22 = 0; dir23 = 0; dir27 = 0;
dir30 = 0; dir31 = 0; dir32 = 0; dir33 = 0; dir37 = 0;
dir40 = 0; dir41 = 0; dir42 = 0; dir43 = 0; dir47 = 0;
nums = rows * columns;
%% 循环计算
% 第一小块
for r = 2 : floor(rows / 2)
    for c = 2 : floor(columns / 2)
        if inputImg(r - 1, c + 1) == 0
            dir17 = dir17 + 1;
        elseif inputImg(r, c + 1) == 0
            dir13 = dir13 + 1;
        elseif inputImg(r + 1, c - 1) == 0
            dir12 = dir12 + 1;
        elseif inputImg(r + 1, c) == 0
            dir11 = dir11 + 1;
        elseif inputImg(r + 1, c + 1) == 0
            dir10 = dir10 + 1;
        end
    end
end
% 第二小块
for r = 2 : floor(rows / 2)
    for c = ceil(columns / 2) : floor(columns - 1)
        if inputImg(r - 1, c + 1) == 0
            dir27 = dir27 + 1;
        elseif inputImg(r, c + 1) == 0
            dir23 = dir23 + 1;
        elseif inputImg(r + 1, c - 1) == 0
            dir22 = dir22 + 1;
        elseif inputImg(r + 1, c) == 0
            dir21 = dir21 + 1;
        elseif inputImg(r + 1, c + 1) == 0
            dir20 = dir20 + 1;
        end
    end
end
% 第三小块
for r = ceil(rows / 2) : rows - 1
    for c = 2 : floor(columns - 1)
        if inputImg(r - 1, c + 1) == 0
            dir37 = dir37 + 1;
        elseif inputImg(r, c + 1) == 0
            dir33 = dir33 + 1;
        elseif inputImg(r + 1, c - 1) == 0
            dir32 = dir32 + 1;
        elseif inputImg(r + 1, c) == 0
            dir31 = dir31 + 1;
        elseif inputImg(r + 1, c + 1) == 0
            dir30 = dir30 + 1;
        end
    end
end
% 第四小块
for r = ceil(rows / 2) : rows - 1
    for c = ceil(columns - 1) : columns - 1
        if inputImg(r - 1, c + 1) == 0
            dir47 = dir47 + 1;
        elseif inputImg(r, c + 1) == 0
            dir43 = dir43 + 1;
        elseif inputImg(r + 1, c - 1) == 0
            dir42 = dir42 + 1;
        elseif inputImg(r + 1, c) == 0
            dir41 = dir41 + 1;
        elseif inputImg(r + 1, c + 1) == 0
            dir40 = dir40 + 1;
        end
    end
end
% 计算概率
dir17 = dir17 / nums / 4; dir13 = dir13 / nums / 4; dir12 = dir12 / nums / 4; dir11 = dir11 / nums / 4; dir10 = dir10 / nums / 4;
dir27 = dir27 / nums / 4; dir23 = dir23 / nums / 4; dir22 = dir22 / nums / 4; dir21 = dir21 / nums / 4; dir20 = dir20 / nums / 4;
dir37 = dir37 / nums / 4; dir33 = dir33 / nums / 4; dir32 = dir32 / nums / 4; dir31 = dir31 / nums / 4; dir30 = dir30 / nums / 4;
dir47 = dir47 / nums / 4; dir43 = dir43 / nums / 4; dir42 = dir42 / nums / 4; dir41 = dir41 / nums / 4; dir40 = dir40 / nums / 4;
a = [dir17 dir13 dir12 dir11 dir10 dir27 dir23 dir22 dir21 dir20 dir37 dir33 dir32 dir31 dir30 dir47 dir43 dir42 dir41 dir40];
end