%% 清空环境变量
close all
clc

%% 主程序
imgRaw = imread('D:\workspace\MATLAB\pic\testjq.jpg');
% imgRaw = imread('D:\workspace\MATLAB\pic\xiao.png');

%% rgb2gray
imgGray = rgb2gray(imgRaw);
figure;
imshow(imgGray);
title('中值滤波前图像');

%% 去噪
% 维纳滤波 不好 有毛刺
% wienerimgBinary = wiener2(imgGray, [5, 5]);
% figure;
% imshow(wienerimgBinary);
% title('维纳滤波图像');
% 中值滤波 淡化网格线
medimgBinary = medfilt2(imgGray, [5, 5]);
figure;
imshow(medimgBinary);
title('中值滤波图像');

%% 二值化
%  Otsu's 阈值分割 两个峰，可以有效去除网格线
T = graythresh(medimgBinary); % 计算Otsu's阈值
imgBinary = im2bw(medimgBinary, T);
figure;
imshow(imgBinary);
title('Otsus 阈值分割图像');
figure;
getwords(imgBinary);
%% 效果还行，但是不能有效去除网格线
% imgBinary = binaryzation(medimgBinary);
% figure;
% imshow(imgBinary);
% title('迭代 阈值分割图像'); 
%% 骨架提取

% Hilditch 骨架提取
% imgThin = thin(imgBinary);
% figure;
% imshow(imgThin);
% title('Hilditch骨架图像');

%% 特征提取
%% 方向特征
directionfeature = directionfeatures(imgBinary);
figure;
plot(directionfeature, 's-');

%% 纹理特征
texturalfeature = texturalfeatures(imgGray);

%% 复杂指数
% complexindex = complexindex(imgBinary);

% %% svm
% train = [];
% train_label = []; % 特征拼接在一起
% test = [];
% test_label = [];
%  model = svmtrain(train_label, train);
% [predict_label,accuracy]=svmpredict(test_label,test,model);
%% 画图
% run('plotF');