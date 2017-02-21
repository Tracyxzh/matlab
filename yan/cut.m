clc; clear all; close all;
[filename, pathname] = uigetfile( '*.jpg;*.jpeg;*.bmp;*.png;*.gif', ...
    'Pick a file');
Mat = [];
if ~filename
    return;
end
img = imread( strcat(pathname, filename) );
imgorign = img;
if ndims(img) == 3
    img = rgb2gray(img);
else
    img = img;
end
figure('Name', 'Trip', 'NumberTitle', 'off', 'MenuBar', 'none'); 
imshow(img, 'Border','tight'); hold on;
P = []; num = 1;
[x, y, k] = ginput(1);
P = [P; x y];
plot(x, y, 'r.', 'MarkerSize', 15);
while k == 1
    num = num + 1;
    [x, y, k] = ginput(1);
    if k ~= 1
        break;
    end
    P = [P; x y];
    plot(x, y, 'r.', 'MarkerSize', 15);
    if num > 1
        line([P(num-1, 1) P(num, 1)], [P(num-1, 2) P(num, 2)], ...
            'Color', 'r', 'LineWidth', 2);
    end    
end
line([P(1, 1) P(end, 1)], [P(1, 2) P(end, 2)], ...
    'Color', 'r', 'LineWidth', 2);
mf = getframe(gca);
If = frame2im(mf);
figure('Name', 'Frame', 'NumberTitle', 'off', 'MenuBar', 'none'); 
img = If;
hsv = rgb2hsv(img);
s = hsv(:, :, 2);
bw = im2bw(s, graythresh(s));
bw_fill = imfill(bw, 'holes');
for i = 1 : size(img, 3)
    imgorign(:, :, i) = imgorign(:, :, i).*uint8(bw_fill);
end
imshow(imgorign, 'Border', 'tight');