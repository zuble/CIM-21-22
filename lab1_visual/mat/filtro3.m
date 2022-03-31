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
% 
% eleph = imread ('img/elephant.bmp');
% [row1,col1,ncorchan1] = size(eleph);
% % figure(fign);imshow(eleph);fign=fign+1;
% 
% fruta = imread ('img/fruta.bmp');
% fruta=rgb2gray(fruta);
% [row2,col2,ncorchan2] = size(fruta);
% % figure(fign);imshow(fruta);fign=fign+1;
% 
% ruido1 = imread ('img/ruido1.jpg');
% [row3,col3,ncorchan3] = size(ruido1);
% % figure(fign);imshow(ruido1);fign=fign+1;
% 
% ruido2 = imread ('img/ruido2.jpg');
% [row4,col4,ncorchan4] = size(ruido2);
% % figure(fign);imshow(ruido2);fign=fign+1;
% 
% casa1 = imread ('img/casa1.jpg');
% [row5,col5,ncorchan5] = size(casa1);
% % figure(fign);imshow(casa1);fign=fign+1;
% 
% casa2 = imread ('img/casa2.jpg');
% [row6,col6,ncorchan6] = size(casa2);
% % figure(fign);imshow(casa2);fign=fign+1;
% 
contorno = imread ('img/contorno.jpg');
% [row7,col7,ncorchan7] = size(contorno);
% % figure(fign);imshow(contorno);fign=fign+1;
% 
% 
% %% 3i
% 
% chosenone = eleph;
% 
% type=["none" "average" "disk" "gaussian" "laplacian" "log" "motion" "prewitt" "sobel"];
% type_len=length(type);
% %{
% 'average' Averaging filter
% 'disk' Circular averaging filter (pillbox)
% 'laplacian' Approximates the two-dimensional Laplacian operator
% 'log' Laplacian of Gaussian filter
% 'motion' Approximates the linear motion of a camera
% 'prewitt' Prewitt horizontal edge-emphasizing filter
% 'sobel' Sobel horizontal edge-emphasizing filter
% gaussiano : imgaussfilt
% %}
% 
% % allocate filtered img
% filtIMG=zeros(row1,col2,type_len+1,'uint8');
% figure(fign);
% for i=1:1:type_len
%     
%     if i == 1
%         subplot(2,5,i);
%         imshow(chosenone);title('original');
%     else
%         subplot(2,5,i);
%         h=fspecial(type(i));
%         filtIMG(:,:,i) = imfilter(chosenone,h,'replicate');
%         imshow(filtIMG(:,:,i));title(type(i));
%     end
%     
% end
% fign=fign+1;
% 
% 
% %% 3ii a+b média/mediana
% h3=fspecial('average',3);
% h5=fspecial('average',5);
% 
% % ruido1
% figure(fign);fign=fign+1;
% subplot(2,2,1);imshow(ruido1);title('ruido1 Original');
% 
% ruido1FA3 = imfilter(ruido1,h3,'conv');
% subplot(2,2,2);imshow(ruido1FA3);title('ruido1 media3*3');
% 
% ruido1FA5 = imfilter(ruido1,h5,'conv');
% subplot(2,2,4);imshow(ruido1FA5);title('ruido1 media5*5');
% 
% ruido1FB = medfilt2(ruido1);
% subplot(2,2,3);imshow(ruido1FB);title('ruido1 mediana');
% 
% % ruido2
% figure(fign);fign=fign+1;
% subplot(2,2,1);imshow(ruido2);title('ruido2 Original');
% 
% ruido2FA3 = imfilter(ruido2,h3,'conv');
% subplot(2,2,2);imshow(ruido2FA3);title('ruido2 media3*3');
% 
% ruido2FA5 = imfilter(ruido2,h5,'conv');
% subplot(2,2,4);imshow(ruido2FA5);title('ruido2 media5*5');
% 
% ruido2FB = medfilt2(ruido2);
% subplot(2,2,3);imshow(ruido2FB);title('ruido2 mediana');
% 
% 
% %% 3ii c sobel
% 
% casa1 = double(casa1);
% casa2 = double(casa2);
% contorno = double(contorno);
% sob_orig = {casa1 casa2 contorno};
% 
% % Pre-allocate
% casa1Sob = zeros(size(casa1));
% casa2Sob = zeros(size(casa2));
% contornoSob = zeros(size(contorno));
% sob_filt = {casa1Sob casa2Sob contornoSob};
% 
% % Sobel Operator Mask
% Sx = [-1 0 1; -2 0 2; -1 0 1];
% Sy = [-1 -2 -1; 0 0 0; 1 2 1];
% 
% % Edge Detection Process
% for k=1:1:3
%     input = sob_orig{k};
% 
%     for i = 1:size(input, 1) - 2
%         for j = 1:size(input, 2) - 2
% 
%             % Gradient approximations
%             Gx = sum(sum(Sx.*input(i:i+2, j:j+2)));
%             Gy = sum(sum(Sy.*input(i:i+2, j:j+2)));
% 
%             % Calculate magnitude of vector
%             sob_filt{k}(i+1, j+1) = sqrt(Gx.^2 + Gy.^2);
% 
%         end
%     end
% 
%     % Filtered Image
%     sob_filt{k} = uint8(sob_filt{k});
% 
%     % Define a threshold value
%     thresholdValue = 100; % varies between [0 255]
%     sob_edge = max(sob_filt{k}, thresholdValue);
%     sob_edge(sob_edge == round(thresholdValue)) = 0;
%     sob_edge = imbinarize(sob_edge);
% 
% 
%     if k==1
%         figure(fign);
%         subplot(2,3,1);
%         imshow(sob_filt{k});title('SOBEL casa1 : filtered');
%         subplot(2,3,4);
%         imshow(sob_edge);title('SOBEL casa1 : edge detected');
%     end
%     if k==2
%         figure(fign);
%         subplot(2,3,2);
%         imshow(sob_filt{k});title('SOBEL casa2 : filtered');
%         subplot(2,3,5);
%         imshow(sob_edge);title('SOBEL casa2 : edge detected');
%     end
%     if k==3
%         figure(fign);
%         subplot(2,3,3);
%         imshow(sob_filt{k});title('SOBEL contorno : filtered');
%         subplot(2,3,6);
%         imshow(sob_edge);title('SOBEL contorno : edge detected');
%     end
% 
% end
% fign=fign+1;
% 
% %% 3ii c prewitt
% 
% casa1 = double(casa1);
% casa2 = double(casa2);
% contorno = double(contorno);
% pwitt_orig = {casa1 casa2 contorno};
% 
% % Pre-allocate
% casa1pwitt = zeros(size(casa1));
% casa2pwitt = zeros(size(casa2));
% contornopwitt = zeros(size(contorno));
% pwitt_filt = {casa1pwitt casa2pwitt contornopwitt};
% 
% % Sobel Operator Mask
% Px = [-1 0 1; -1 0 1; -1 0 1];
% Py = [-1 -1 -1; 0 0 0; 1 1 1];
% 
% % Edge Detection Process
% for k=1:1:3
%     input = pwitt_orig{k};
% 
%     for i = 1:size(input, 1) - 2
%         for j = 1:size(input, 2) - 2
% 
%             % Gradient approximations
%             Gx = sum(sum(Px.*input(i:i+2, j:j+2)));
%             Gy = sum(sum(Py.*input(i:i+2, j:j+2)));
% 
%             % Calculate magnitude of vector
%             pwitt_filt{k}(i+1, j+1) = sqrt(Gx.^2 + Gy.^2);
% 
%         end
%     end
% 
%     % Filtered Image
%     pwitt_filt{k} = uint8(pwitt_filt{k});
% 
%     % Define a threshold value
%     thresholdValue = 110; % varies between [0 255]
%     pwitt_edge = max(pwitt_filt{k}, thresholdValue);
%     pwitt_edge(pwitt_edge == round(thresholdValue)) = 0; %#ok<NASGU>
%     pwitt_edge = imbinarize(pwitt_edge);
% 
% 
%     if k==1
%         figure(fign);
%         subplot(2,3,1);
%         imshow(pwitt_filt{k});title('PREWITT casa1 : filtered');
%         subplot(2,3,4);
%         imshow(pwitt_edge);title('PREWITT casa1 : edge detected');
%     end
%     if k==2
%         figure(fign);
%         subplot(2,3,2);
%         imshow(pwitt_filt{k});title('PREWITT casa2 : filtered');
%         subplot(2,3,5);
%         imshow(pwitt_edge);title('PREWITT casa2 : edge detected');
%     end
%     if k==3
%         figure(fign);
%         subplot(2,3,3);
%         imshow(pwitt_filt{k});title('PREWITT contorno : filtered');
%         subplot(2,3,6);
%         imshow(pwitt_edge);title('PREWITT contorno : edge detected');
%     end
% 
% end
% fign=fign+1;
% 
% 
% 
% BW1 = edge(casa1,'sobel');
% figure;
% imshow(BW1)
% title('Sobel Filter');

%% 3 iii canny edge

%DEBUG
% all_valid = true;
% flen = length(F);
% for K = 1 : flen
%   if isempty(F(K).cdata)
%     all_valid = false;
%     K
%   end
% end
% if ~all_valid
%    error('Did not write movie because of empty frames')
% end


v = VideoWriter('namefile.mp4','MPEG-4');
v.FrameRate = 6;
open(v);

startdate=1;
enddate=10;

fig=figure;
set(fig, 'position',[1 1 750 525])



for sigma=0.1:0.2:1.5
    for low=0.05:0.05:0.5
        for high=0.95:-0.05:low+0.2
            figure(fign)
            canny_filt = edge(contorno,'canny', [low high] , sigma);
            imshow(canny_filt);
            s=num2str(sigma);l=num2str(low);h=num2str(high);
            t=strcat('SIGMA ',s,' | [',l,h,']');
            title(t);
            
            pause(0.05)
            
            currFrame = getframe(gcf);
            writeVideo(v,currFrame);
        end
        pause(0.05)
    end
    pause(0.05)
end



close(v);