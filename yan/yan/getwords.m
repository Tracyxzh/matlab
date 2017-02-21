function [ a, b ] = getwords( inputImg )
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

figure;
a = findpeaks(rowhist,10,10,0);
figure;
b = findpeaks(columnhist,10,10,0);
end

