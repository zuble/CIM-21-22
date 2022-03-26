clear all;
close all;
clc;
fign=1;


%% opens all img in a folder and converts to grey scale

% myFolder='C:\_infernoup\CIM-21-22\lab1_visual\mat\img';       
% filePattern = fullfile(myFolder,'*.bmp'); 
% theFiles = dir(filePattern);      
% nfiles = length(theFiles);    % Number of files found
% for ii=1:nfiles
%    currentfilename = theFiles(ii).name;
%    currentimage = imread(currentfilename);
%    [row,col,ncorchan] = size(currentimage);
%    if ncorchan ~= 1
%        currentimage=rgb2gray(currentimage);
%    end
%    images{ii} = currentimage;
% end


%% open img in arcaic way

eleph = imread ('img/elephant.bmp');
[row1,col1,ncorchan1] = size(eleph);
% figure(fign);imshow(eleph);fign=fign+1;

fruta = imread ('img/fruta.bmp');
fruta=rgb2gray(fruta);
[row2,col2,ncorchan2] = size(fruta);
% figure(fign);imshow(fruta);fign=fign+1;

ruido1 = imread ('img/ruido1.jpg');
[row3,col3,ncorchan3] = size(ruido1);
% figure(fign);imshow(ruido1);fign=fign+1;

ruido2 = imread ('img/ruido2.jpg');
[row4,col4,ncorchan4] = size(ruido2);
% figure(fign);imshow(ruido2);fign=fign+1;

casa1 = imread ('img/casa1.jpg');
[row5,col5,ncorchan5] = size(casa1);
% figure(fign);imshow(casa1);fign=fign+1;

casa2 = imread ('img/casa2.jpg');
[row6,col6,ncorchan6] = size(casa2);
% figure(fign);imshow(casa2);fign=fign+1;

contorno = imread ('img/contorno.jpg');
[row7,col7,ncorchan7] = size(contorno);
% figure(fign);imshow(contorno);fign=fign+1;


%% 3i

chosenone = fruta;

type=["average" "disk" "gaussian" "laplacian" "log" "motion" "prewitt" "sobel"];
type_len=length(type);
%{
'average' Averaging filter
'disk' Circular averaging filter (pillbox)
'laplacian' Approximates the two-dimensional Laplacian operator
'log' Laplacian of Gaussian filter
'motion' Approximates the linear motion of a camera
'prewitt' Prewitt horizontal edge-emphasizing filter
'sobel' Sobel horizontal edge-emphasizing filter
gaussiano : imgaussfilt
%}

% allocate filtered img
filtIMG=zeros(row1,col2,type_len+1);

for i=1:1:type_len
    h=fspecial(type(i));
    filtIMG(:,:,i) = imfilter(chosenone,h,'replicate');
%     figure(fign);imshowpair(chosenone,filtIMG(:,:,i),'montage');
%     title(type(i));fign=fign+1;
end

% gaussian filter of original
filtIMG(:,:,type_len+1) = imgaussfilt(chosenone,0.5); %def standard deviation 0.5
% figure(fign);imshowpair(chosenone,filtIMG(:,:,type_len+1),'montage');fign=fign+1;
% title('original VS gaussianFiltered');


%% 3ii a média
h3=fspecial('average',3);
h5=fspecial('average',5);

ruido1FA3 = imfilter(ruido1,h3,'conv');
figure(fign);imshowpair(ruido1,ruido1FA3,'montage');fign=fign+1;
title('ruido1A: orig VS media3*3');

ruido1FA5 = imfilter(ruido1,h5,'conv');
figure(fign);imshowpair(ruido1,ruido1FA5,'montage');fign=fign+1;
title('ruido1A: orig VS media5*5');


ruido2FA3 = imfilter(ruido2,h3,'conv');
figure(fign);imshowpair(ruido2,ruido2FA3,'montage');fign=fign+1;
title('ruido2A: orig VS media3*3');

ruido2FA5 = imfilter(ruido2,h5,'conv');
figure(fign);imshowpair(ruido2,ruido2FA5,'montage');fign=fign+1;
title('ruido2A: orig VS media5*5');



%% 3ii b mediana

ruido1FB = medfilt2(ruido1);
figure(fign);imshowpair(ruido1,ruido1FB,'montage');fign=fign+1;
title('ruido1B: orig VS mediana');

ruido2FB = medfilt2(ruido2);
figure(fign);imshowpair(ruido2,ruido2FB,'montage');fign=fign+1;
title('ruido2B: orig VS mediana');


%% 3ii c sobel

casa1 = double(casa1);
casa2 = double(casa2);
contorno = double(contorno);
sob_orig = {casa1 casa2 contorno};

% Pre-allocate 
casa1Sob = zeros(size(casa1));
casa2Sob = zeros(size(casa2));
contornoSob = zeros(size(contorno));
sob_filt = {casa1Sob casa2Sob contornoSob};

% Sobel Operator Mask
Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [-1 -2 -1; 0 0 0; 1 2 1];
  
% Edge Detection Process
% When i = 1 and j = 1, then filtered_image pixel  
% position will be filtered_image(2, 2)
% The mask is of 3x3, so we need to traverse 
% to filtered_image(size(input_image, 1) - 2
%, size(input_image, 2) - 2)
% Thus we are not considering the borders.
for k=1:1:3
    input = sob_orig{k};
   
    for i = 1:size(input, 1) - 2
        for j = 1:size(input, 2) - 2

            % Gradient approximations
            Gx = sum(sum(Sx.*input(i:i+2, j:j+2)));
            Gy = sum(sum(Sy.*input(i:i+2, j:j+2)));

            % Calculate magnitude of vector
            sob_filt{k}(i+1, j+1) = sqrt(Gx.^2 + Gy.^2);

        end
    end
    
    % Filtered Image
    sob_filt{k} = uint8(sob_filt{k});
    
    % Define a threshold value
    thresholdValue = 100; % varies between [0 255]
    sob_edge = max(sob_filt{k}, thresholdValue);
    sob_edge(sob_edge == round(thresholdValue)) = 0;
    sob_edge = imbinarize(sob_edge);
    
 
    figure(fign);imshowpair(sob_filt{k},sob_edge,'montage');fign=fign+1;
    title('SOBEL:Filtered Image VS Edge Detected Image');

end


%% 3ii c prewitt

casa1 = double(casa1);
casa2 = double(casa2);
contorno = double(contorno);
pwitt_orig = {casa1 casa2 contorno};

% Pre-allocate 
casa1pwitt = zeros(size(casa1));
casa2pwitt = zeros(size(casa2));
contornopwitt = zeros(size(contorno));
pwitt_filt = {casa1pwitt casa2pwitt contornopwitt};

% Sobel Operator Mask
Px = [-1 -1 -1; 0 0 0; 1 1 1];
Py = [1 0 -1; 1 0 -1; 1 0 1];
  
% Edge Detection Process
% When i = 1 and j = 1, then filtered_image pixel  
% position will be filtered_image(2, 2)
% The mask is of 3x3, so we need to traverse 
% to filtered_image(size(input_image, 1) - 2
%, size(input_image, 2) - 2)
% Thus we are not considering the borders.
for k=1:1:3
    input = pwitt_orig{k};
   
    for i = 1:size(input, 1) - 2
        for j = 1:size(input, 2) - 2

            % Gradient approximations
            Gx = sum(sum(Sx.*input(i:i+2, j:j+2)));
            Gy = sum(sum(Sy.*input(i:i+2, j:j+2)));

            % Calculate magnitude of vector
            pwitt_filt{k}(i+1, j+1) = sqrt(Gx.^2 + Gy.^2);

        end
    end
    
    % Filtered Image
    pwitt_filt{k} = uint8(pwitt_filt{k});
    
    % Define a threshold value
    thresholdValue = 100; % varies between [0 255]
    pwitt_edge = max(pwitt_filt{k}, thresholdValue);
    pwitt_edge(pwitt_edge == round(thresholdValue)) = 0; %#ok<NASGU>
    pwitt_edge = imbinarize(pwitt_edge);
    
 
    figure(fign);imshowpair(pwitt_filt{k},pwitt_edge,'montage');fign=fign+1;
    title('PREWITT:Filtered Image VS Edge Detected Image');

end

%% 3 iii canny edge

% for sigma=0.1:0.1:8
%     for low=0.05:0.1:0.90
%         for high=0.95:-0.1:low+0.05
%             canny_filt = edge(contorno,'canny', [low high] , sigma);
%             imshow(canny_filt);
%             s=num2str(sigma);l=num2str(low);h=num2str(high);
%             t=strcat('SIGMA ',s,' | [',l,h,']');
%             title(t);
%             pause(0.1)
%         end
%         pause(0.1)
%     end 
%     pause(0.1)
% end