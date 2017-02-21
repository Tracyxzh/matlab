function [ rcutp, ccutp ] = getwords( inputImg )
%getwords ��ȡ��������
%   ͨ�����е�ͶӰ���ҵ��ָ�㣬�ָ��ַ�
inputImg = ~inputImg;
%% ��ͼ���С
[rows, columns] = size(inputImg);

%% ��ʼ��
rowhist = ones(1, rows); % �洢ÿ��Ϊ�ڵĸ���
columnhist = ones(1, columns);

%% ѭ������
for c = 1 : columns % �ȷָ���
    columnhist(1, c) = sum(inputImg(:, c));
end

for r = 1 : rows % �ٷָ���
    rowhist(1, r) = sum(inputImg(r, :));
end

%% �ҵ��ָ��
% ��ʼ��
T = 10;
rcutp = []; % �洢�ָ��
ccutp = [];
for c = 10 : columns - 10 % �зָ��
    if columnhist(1, c) > T
        rcutp = [rcutp c];
    end
end

for r = 10 : rows - 10 % �зָ��
    if rowhist(1, r) > T
        ccutp = [ccutp c];
    end
end
a = bkm_sm(rowhist);
b = bkm_sm(columnhist);
figure;
bar(rowhist);
figure;
bar(columnhist);
end

