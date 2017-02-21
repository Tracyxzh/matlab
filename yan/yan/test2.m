 
clear,clc,close all;
I=imread('D:\workspace\MATLAB\pic\testjq.jpg');
imshow(I);title('Original image');
gray=rgb2gray(I);figure,imshow(gray);title('Grayscale image');
bw=edge(gray,'canny');
theta=1:180;
[R,xp]=radon(bw,theta);
[I0,J]=find(R>=max(max(R)));%J¼ÇÂ¼ÁËÇãĞ±½Ç
qingxiejiao=90-J
I1=imrotate(I,qingxiejiao,'bilinear','crop');
figure,imshow(I1);title('correct image');
