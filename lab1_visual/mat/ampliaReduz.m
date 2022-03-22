clear all;
clc;


espiraOrig = imzoneplate;
% figure(9);imshow(espiraOrig)


%IMRESIZE
method=["nearest" "bilinear" "bicubic" "box" "triangle" "cubic" "lanczos2" "lanczos3"];
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

for i=1:1:8
    
    espiraRe = imresize(espiraOrig,1.5,method(i));
    
    figure(i);imshowpair(espiraOrig,espiraRe,'montage');
    
end


%RESAMPLEresample;