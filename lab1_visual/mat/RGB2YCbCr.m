rgb=imread('C:\Users\UTILIZADOR\Desktop\CIM\Trabalho 2\scriptsMatlab\imagens\praia.bmp');
YCbCr = rgb2ycbcr(rgb);

figure(1); imshow(YCbCr); title ('Original in YCbCr');

Y = YCbCr(:,:,1);
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

figure(2); imshow(Y); title ('Luma');
 
figure(3); imshow(Cb); title ('Blue difference');
  
figure(4); imshow(Cr); title ('Red difference');