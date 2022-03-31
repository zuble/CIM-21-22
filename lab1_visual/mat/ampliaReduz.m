clear all;
close all;
clc;

% original
espiraOrig = imzoneplate;
[rows, columns, numberOfColorChannels] = size(espiraOrig);


%%  IMRESIZE
method=["none" "nearest" "bilinear" "bicubic" "lanczos3"];
method_len = length(method);
%{ 
'nearest' ~ Nearest-neighbor interpolation
    the output pixel is assigned the value of the pixel that the point falls within. 
    No other pixels are considered.
'bilinear' ~ Bilinear interpolation
    the output pixel value is a weighted average of pixels in the nearest 2-by-2 neighborhood
'bicubic' ~ Bicubic interpolation (default)
    the output pixel value is a weighted average of pixels in the nearest 4-by-4 neighborhood
    can produce pixel values outside the original range.
'box'       Box-shaped kernel
'triangle'	Triangular kernel (equivalent to 'bilinear')
'cubic'     Cubic kernel (equivalent to 'bicubic')
'lanczos2'	Lanczos-2 kernel
'lanczos3'	Lanczos-3 kernel
%}


% figure2 range of pixels controls
RF = 0.5;     %resize factor
Xor=1;    %original start pixel
Yor=500;    %original finish pixel
Xre=Xor*RF; %resized start pixel
Yre=Yor*RF; %resized finish pixel


% allocate resized pictures
espiraRe_len = round(RF * rows);
espiraResize = zeros( espiraRe_len , espiraRe_len , method_len ); 


% gaussian filter of original
espiraOrigFilt = imgaussfilt(espiraOrig,0.5); %def standard deviation 0.5
f1=figure(1);imshowpair(espiraOrig(200:400,200:400),espiraOrigFilt(200:400,200:400),'montage');
% f1=figure(1);imshowpair(espiraOrig,espiraOrigFilt,'montage');
title('original--gaussianFiltered');set(f1,'Name','original--gaussianFiltered');

%espiraOrig = espiraOrigFilt;

f2=figure(2);f3=figure(3);f4=figure(4);f5=figure(5);

% resize
for i=1:1:method_len
    
    %cut resized by controls
    figure(2);
    subplot(2,3,i);
    if i == 1
        imshow(espiraOrig(Xor:Yor,Xor:Yor));title(method(i));
    else
        espiraResize(:,:,i) = imresize(espiraOrig, RF , method(i));
        imshow(espiraResize(Xre:Yre,Xre:Yre,i));title(method(i))
        %imshow(espiraResize(100:115,100:115,i));title(method(i))
    end
    
    
    %full resized pics
    figure(3);
    if i ~= 1
        imshowpair(espiraOrig,espiraResize(:,:,i),'montage');title(method(i))
    end

    
    % densidade espectral
    figure(4);
    subplot(2,3,i);
    if i == 1 
        imagesc( log10(abs(fftshift(fft2(espiraOrig(Xor:Yor,Xor:Yor)))).^2 ));
        title('densidade espetral original');
    else
        imagesc( log10(abs(fftshift(fft2(espiraResize(Xre:Yre,Xre:Yre,i)))).^2 ));
        title(method(i))
    end
   
    
    %variação do sinal no espaço
    figure(5);
    subplot(2,3,i);
    if i == 1
        histogram(espiraOrig(Xor:Yor,Xor:Yor),20);title('pdf original');
    else
        histogram(espiraResize(Xre:Yre,Xre:Yre,i),20);title(method(i))
    end
    
end
set(f2,'Name','resized interpolated img');
set(f4,'Name','densidade espetral');
set(f5,'Name','variação do sinal no espaço');


% diff entre methods interpolação 
% for i=1:1:method_len-3
%     
%         f5=figure(fign);
%         subplot(2,3,i);
%         dif = log10(abs(fftshift(fft2(espiraResize(:,:,3)))).^2 ) - log10(abs(fftshift(fft2(espiraResize(:,:,i)))).^2 );
%         imagesc(dif);
%         t = strcat('diff dens espetral (bicubic-',method(i),')');title(t);
%     
% end
% fign=fign+1;

%%  RESAMPLE
% espiraResample = zeros( espiraRe_len , espiraRe_len ); %#ok<PREALL>
% espiraResample = resample(espiraOrig,1,1/refator);
% f6=figure(fign);imshowpair(espiraOrig,espiraResample,'montage');
% set(f6,'Name','original--resample');fign=fign+1;




