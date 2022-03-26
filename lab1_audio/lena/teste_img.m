%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%   LENA512  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

fn = 'lena512.bmp';
SNR = zeros(1,7);
NBITS = [2:1:8] ;

sig = imread(fn);
sig = single(sig)/255.0;
imshow(sig);
title('original');


for i = 1:length(NBITS)

    aux = sig .* (2.^(NBITS(i)-1));
    aux = floor(aux + 0.5);
    sigQ2 = aux ./ (2 .^ (NBITS(i)-1));
    
%     imshow(sigQ2)
    
    sigE = abs(sigQ2 - sig);
    SNR(i) = 10*log10(var(sig)/var(sigE));
end

% pfit = polyfit(NBITS, SNR, 1);
plot(NBITS , SNR )
% hold on
% plot(NBITS, pfit(1).*NBITS+pfit(2));
title('SNR / NBITS');xlabel('NBITS');ylabel('SNR')
% h = gcf;
% exportgraphics(h,'lena512_SNR.png')