function thirdmoment = thirdmoment( inputImg, m )
%thirdmoment ���׾�
%   �˴���ʾ��ϸ˵��

% ��ͼ���С
[rows, columns] = size(inputImg);

% ��ʼ��
thirdmoment = 0;

% ѭ������
for r = 1 : rows
    for c = 1 : columns
        thirdmoment = thirdmoment + (inputImg(r,c) - m) ^ 3;
    end
end
        
end

