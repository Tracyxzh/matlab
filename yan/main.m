%% ��ջ�������
close all
clc

%% ������
imgRaw = imread('D:\workspace\MATLAB\pic\testjq.jpg');
% imgRaw = imread('D:\workspace\MATLAB\pic\xiao.png');

%% rgb2gray
imgGray = rgb2gray(imgRaw);
figure;
imshow(imgGray);
title('��ֵ�˲�ǰͼ��');

%% ȥ��
% ά���˲� ���� ��ë��
% wienerimgBinary = wiener2(imgGray, [5, 5]);
% figure;
% imshow(wienerimgBinary);
% title('ά���˲�ͼ��');
% ��ֵ�˲� ����������
medimgBinary = medfilt2(imgGray, [5, 5]);
figure;
imshow(medimgBinary);
title('��ֵ�˲�ͼ��');

%% ��ֵ��
%  Otsu's ��ֵ�ָ� �����壬������Чȥ��������
T = graythresh(medimgBinary); % ����Otsu's��ֵ
imgBinary = im2bw(medimgBinary, T);
figure;
imshow(imgBinary);
title('Otsus ��ֵ�ָ�ͼ��');
figure;
getwords(imgBinary);
%% Ч�����У����ǲ�����Чȥ��������
% imgBinary = binaryzation(medimgBinary);
% figure;
% imshow(imgBinary);
% title('���� ��ֵ�ָ�ͼ��'); 
%% �Ǽ���ȡ

% Hilditch �Ǽ���ȡ
% imgThin = thin(imgBinary);
% figure;
% imshow(imgThin);
% title('Hilditch�Ǽ�ͼ��');

%% ������ȡ
%% ��������
directionfeature = directionfeatures(imgBinary);
figure;
plot(directionfeature, 's-');

%% ��������
texturalfeature = texturalfeatures(imgGray);

%% ����ָ��
% complexindex = complexindex(imgBinary);

% %% svm
% train = [];
% train_label = []; % ����ƴ����һ��
% test = [];
% test_label = [];
%  model = svmtrain(train_label, train);
% [predict_label,accuracy]=svmpredict(test_label,test,model);
%% ��ͼ
% run('plotF');