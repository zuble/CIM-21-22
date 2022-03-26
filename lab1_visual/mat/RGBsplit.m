
k = imread('C:\Users\UTILIZADOR\Desktop\CIM\Trabalho 2\scriptsMatlab\imagens\praia.bmp');

size(k);
 figure(1); imshow(k); title ('Original Image');
 r = k(:, :, 1);
 g = k(:, :, 2);
 b = k(:, :, 3);
  figure(2); imshow(r); title ('Red Split');
 
  figure(3); imshow(g); title ('Green Split');
  
  figure(4); imshow(b); title ('Blue Split');
 
 im2 = uint8(zeros(768, 1024, 3)); % criada uma imagem só de zeros
 im3 = uint8(zeros(768, 1024, 3)); % criada uma imagem só de zeros
 im4 = uint8(zeros(768, 1024, 3)); % criada uma imagem só de zeros
 
  im2(:, :, 1) = r;
  im3(:, :, 2) = g;
  im4(:, :, 3) = b; 
  
  figure(5); imshow(im2);
 
  figure(6); imshow(im3);
  
  figure(7); imshow(im4);
  
rgbImage = cat(3, r, g, b);
figure (8); imshow(rgbImage); title ('RGB reconstruction');


 