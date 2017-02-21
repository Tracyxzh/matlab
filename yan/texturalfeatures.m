function texfeature= texturalfeatures( inputImg )
%texfeature �����������
%   �����������

%% ����ֵ�ͷ��ƽ����
mean = mean2(inputImg); %��ֵ
std = std2(inputImg); %����
somthness = 1 - 1 / (1 + std^2); %ƽ����

%% ���Ҷȸ���ֱ��ͼ
histim = imhist(inputImg); %����ֱ��ͼ
columns = size(histim, 1); 
% ��ʼ��
phistim = zeros(1, columns);
sumhist = sum(histim);
% �Ҷȸ���ֱ��ͼ
for c = 1 : columns
    phistim(c) = histim(c) / sumhist;
end
%% ���׾�
skewness = 0;
for c = 1 : columns
    skewness = skewness + (c - mean) * phistim(c);
end

%% һ����
uniform = 0;
for c = 1 : columns
    uniform = uniform + phistim(c) ^ 2;
end

%% ����
energe = 0;
for c = 1 : columns
    energe = energe + phistim(c) * log2(phistim(c));
end

texfeature = [mean,std,somthness,skewness,uniform,energe];
end

