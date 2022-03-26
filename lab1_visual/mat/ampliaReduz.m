clear all;
close all;
clc;
fign=1;


% original
espiraOrig = imzoneplate;
[rows, columns, numberOfColorChannels] = size(espiraOrig);
% figure(fign);imshow(espiraOrig)
fign=fign+1;

%%  IMRESIZE
method=["nearest" "bilinear" "bicubic" "box" "lanczos2" "lanczos3"];
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

refator = 0.5;

% allocate resized pictures
espiraRe_len = round(refator * rows );
espiraResize = zeros( espiraRe_len , espiraRe_len , method_len ); 

% gaussian filter of original
espiraOrig2 = imgaussfilt(espiraOrig,0.5); %def standard deviation 0.5
f1=figure(fign);imshowpair(espiraOrig,espiraOrig2,'montage');fign=fign+1;
set(f1,'Name','original--gaussianFiltered');

% resize
for i=1:1:method_len
    
    espiraResize(:,:,i) = imresize(espiraOrig,refator,method(i));
 
    f2=figure(fign);imshowpair(espiraOrig,espiraResize(:,:,i),'montage');
    set(f2,'Name',method(i));fign=fign+1;
    
    % densidade espectral + variação do sinal no espaço
    figure(method_len+3);subplot(3,2,i);
    imagesc( log10(abs(fftshift(fft2(espiraOrig))).^2 ));
    title(method(i))
    
end
fign=fign+1;

%%  RESAMPLE
% espiraResample = zeros( espiraRe_len , espiraRe_len ); %#ok<PREALL>
% espiraResample = resample(espiraOrig,1,1/refator);
% f3=figure(fign);imshowpair(espiraOrig,espiraResample,'montage');
% set(f3,'Name','original--resample');fign=fign+1;




