function hist = smoothline( array )
%smoothline ƽ���˲�
%   �˴���ʾ��ϸ˵��

% �������С
n = size(array, 2);

% ƽ���˲�
for i = 2 : n - 2
    array(i) = (array(i - 1) + array(i) + array(1 + 1)) / 3;
end

hist = array;

end

