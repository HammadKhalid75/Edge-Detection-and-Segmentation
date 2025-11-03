%% Lab 5: Edge Detection and Segmentation
%  Author: <YOUR NAME>
%  Date  : <TODAY>
close all; clear; clc;

%--- Load image ------------------------------------------------------------
I = im2double(rgb2gray(imread('peppers.png')));

% Create folder for results
if ~exist('results','dir'), mkdir('results'); end

%% 1) Basic derivative filters (Sobel, Prewitt)
edges_sobel   = edge(I,'Sobel');
edges_prewitt = edge(I,'Prewitt');

h1 = figure('Color','w');
montage({edges_sobel, edges_prewitt},'Size',[1 2]);
title('Sobel | Prewitt edges');
saveas(h1,'results/01_sobel_prewitt.png');

%% 2) Canny detector (multi-stage)
edges_canny = edge(I,'Canny',[0.05 0.2]);

h2 = figure('Color','w');
imshow(edges_canny); title('Canny edges');
saveas(h2,'results/02_canny.png');

%% 3) Laplacian of Gaussian (LoG)
edges_log = edge(I,'log');

h3 = figure('Color','w');
imshow(edges_log); title('Laplacian of Gaussian edges');
saveas(h3,'results/03_log.png');

%% 4) Edge map → segmentation (Otsu threshold)
level = graythresh(I);            % Otsu method
BW    = imbinarize(I,level);

h4 = figure('Color','w');
montage({I,BW},'Size',[1 2]);
title('Original | Otsu binary mask');
saveas(h4,'results/04_otsu.png');

%% 5) Label and visualize regions
[L,num] = bwlabel(BW);
RGB     = label2rgb(L,'jet','k','shuffle');

h5 = figure('Color','w');
imshow(RGB); 
title(['Labeled regions: ',num2str(num)]);
saveas(h5,'results/05_labeled.png');

%% 6) Save a copy of the original for the README
imwrite(I,'results/00_original.png');

disp('All figures saved in folder results/');