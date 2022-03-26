rgb=imread('C:\Users\UTILIZADOR\Desktop\CIM\Trabalho 2\scriptsMatlab\imagens\praia.bmp');
HSV = rgb2hsv(rgb);
figure(1); imshow(HSV); title ('Original in HSV');

h = HSV(:,:,1);
s = HSV(:,:,2);
v = HSV(:,:,3);

figure(2); imshow(h); title ('Hue');
 
figure(3); imshow(s); title ('Saturation');
  
figure(4); imshow(v); title ('Lightness');