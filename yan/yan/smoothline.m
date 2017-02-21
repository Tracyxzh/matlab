function hist = smoothline( array )
%smoothline 平滑滤波
%   此处显示详细说明

% 求数组大小
n = size(array, 2);

% 平滑滤波
for i = 2 : n - 2
    array(i) = (array(i - 1) + array(i) + array(1 + 1)) / 3;
end

hist = array;

end

