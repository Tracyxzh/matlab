function a = complexindex( inputImg )
% 复杂指数
%   复杂指数

% 求图象大小
[rows, columns] = size(inputImg);

% 初始化和
sum = 0;
sumx = 0;
sumy = 0;


% 循环求重量，黑色为1，白色为2
for r = 1 : rows
    for c = 1 : columns
        if inputImg(r, c) == 0
            sum = sum + 1;
        end
    end
end

% 循环sumx , sumy
for r = 1 : rows
    for c = 1 : columns
        sumx = sumx + r * (1 - inputImg(r, c));
        sumy = sumy + c *(1 - inputImg(r, c));
    end
end

% 循环求质心
Gx = sumx / sum;
Gy = sumy / sum;

% 初始化
sumxx = 0;
sumyy = 0;

% 求质心二次方根
for r = 1 : rows
    for c = 1 : columns
        sumxx = sumxx + (r - Gx)^2 *(1 - inputImg(r, c));
        sumyy = sumyy + (c - Gy)^2 * (1 - inputImg(r, c));
    end
end

deltax = round(sqrt(sumxx / sum));
deltay = round(sqrt(sumyy / sum));
% 复杂指数
Lx = 0;
Ly = 0;
for c = 1 : columns
    Lx = Lx + (1 - inputImg(deltax, c));
end
for r = 1 : rows
    Ly = Ly + (1 - inputImg(r, deltay));
end
Cx = Lx / deltax;
Cy = Ly / deltay;
a = [Cx, Cy];
end

