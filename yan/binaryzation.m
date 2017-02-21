function imgInput = binaryzation( imgInput )
%binaryzation
%   ������ֵ��

imgInput = double(imgInput);
% ��ͼ���С
[row, column] = size(imgInput);

% Ԥ��ָ����Χ
set  = 1;

% ѡ���ʼ��ֵ
oldThreShold = max(max(imgInput)) - min(min(imgInput));
newThreShold = 0;
disThreShold = abs(newThreShold - oldThreShold);

% ���������ֵ�ĻҶ���ֵ��С����ֵ�ĻҶ���ֵ
sumUp = 0; nUp = 0;
sumDown = 0; nDown = 0;

% ��ֵ����
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
    % �����µ���ֵ
    newThreShold = (sumUp / nUp + sumDown / nDown) / 2;
    disThreShold = abs(newThreShold - oldThreShold);
    oldThreShold = newThreShold;
end
% ��ͼ���ֵ������
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

