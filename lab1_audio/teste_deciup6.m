close all;
clear all;
clc;


[sig_wav,FS]=audioread('sting22.wav');
sound(sig_wav,FS,16);pause(20);
sig_img = imread('lena512.bmp');
sig_img=single(sig_img)/255.0;
% imshow(sig_img);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% decimate - retira 1 amostra a cada 2 ou 4 amostras
down2_wav = downsample(sig_wav,2); 
sound(down2_wav,FS/2,16);pause(20);
down4_wav = downsample(sig_wav,4);
% sound(down4_wav,FS,16);pause(20);

down2_img = downsample(sig_img,2);
down4_img = downsample(sig_img,4);
figure(1);imshowpair(down2_img,down4_img,'montage');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sobre-amostragem - 0 a cada 2 ou 4 amostras
up2_wav = upsample(down2_wav,2);    
sound(up2_wav,FS,16);pause(20);
up4_wav = upsample(down4_wav,4);
% sound(up4_wav,FS,16);pause(20);

up2_img = upsample(down2_img,2);
up4_img = upsample(down4_img,4);
figure(2);imshowpair(up2_img,up4_img,'montage');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILTER
h2=ones(2,1); h4=ones(4,1);

f2_wav = filter(h2,1,up2_wav);
sound(f2_wav,FS,16);pause(20);
f4_wav = filter(h4,1,up4_wav);
% sound(f4_wav,FS,16);pause(20);

f2_img = filter2(h2,1,up2_img);
f4_img = filter2(h4,1,up4_img);
figure(3);imshowpair(f2_img , f4_img,'montage');