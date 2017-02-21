function a = complexindex( inputImg )
% ����ָ��
%   ����ָ��

% ��ͼ���С
[rows, columns] = size(inputImg);

% ��ʼ����
sum = 0;
sumx = 0;
sumy = 0;


% ѭ������������ɫΪ1����ɫΪ2
for r = 1 : rows
    for c = 1 : columns
        if inputImg(r, c) == 0
            sum = sum + 1;
        end
    end
end

% ѭ��sumx , sumy
for r = 1 : rows
    for c = 1 : columns
        sumx = sumx + r * (1 - inputImg(r, c));
        sumy = sumy + c *(1 - inputImg(r, c));
    end
end

% ѭ��������
Gx = sumx / sum;
Gy = sumy / sum;

% ��ʼ��
sumxx = 0;
sumyy = 0;

% �����Ķ��η���
for r = 1 : rows
    for c = 1 : columns
        sumxx = sumxx + (r - Gx)^2 *(1 - inputImg(r, c));
        sumyy = sumyy + (c - Gy)^2 * (1 - inputImg(r, c));
    end
end

deltax = round(sqrt(sumxx / sum));
deltay = round(sqrt(sumyy / sum));
% ����ָ��
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

