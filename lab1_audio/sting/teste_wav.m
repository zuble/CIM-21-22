%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%   STING22  %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

SNR1 = zeros(1,8); SNR2 = zeros(1,8); SNR3 = zeros(1,8);
NBITS = [2:2:16] ; %2 4 6 8 10 12 14 16 bits
CORRsin = zeros(1,length(NBITS));

[sig,FS]=audioread('sting22.wav');
info = audioinfo('sting22.wav');

for i = 1:length(NBITS)
    
    %%%%%%%%%%%
    % quantiz %
    salto = 2/(2^NBITS(i));
    limites = [ (-1+salto) : salto : 1-salto ];
    dicionario = [ (-1+(salto/2)) : salto : 1-(salto/2) ]; 
    [index,sigQ1] = quantiz(sig,limites,dicionario);
    
    
    sigQ2 = sig.*(2 .^ (NBITS(i)-1));
    sigQ2 = floor(sigQ2 + 0.5);
    sigQ2 = sigQ2 ./ (2 .^ (NBITS(i)-1));
   
 %{   
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % save quantitized audio %
%     n = num2str(NBITS1(i));
%     filename_wav = strcat('sting22Q',n,'.wav');
%     audiowrite(filename_wav,sigQ,FS,'BitsPerSample',16 ); %bit depth = 16 / resolution = 2^16 = 65,536 possible levels that can be captured
 %}   

    %%%%%%%
    % SNR %
    sigE1 = sigQ1' - sig;
    sigE2 = sigQ2 - sig;
    
    SNR1(i) = snr(sig,sigE1);
    SNR2(i) = 10 .* log10(var(sigQ2) ./ var(sigE1));
    SNR3(i) = 10 * log10( mean( sig .^ 2 ) / mean( sigE1 .^ 2 ) );

    %%%%%%%%
    % CORR %
    aux = corrcoef(sigE2, sig);
    CORRsin(i) = aux(1,2);
end

%%%%%%%%%%%% SNR %%%%%%%%%%%%%%%
poly1=polyfit(NBITS,SNR1,1); poly2=polyfit(NBITS,SNR2,1); poly3=polyfit(NBITS,SNR3,1);

%%%%%%%%%%%%%%%%%%
%        1       %
figure
plot(NBITS , SNR1)
hold on
plot(NBITS, poly1(1).*NBITS+poly1(2));
hold off
title('SNR1 / NBITS');xlabel('NBITS');ylabel('SNR(dB)');
legend('SNR1', 'POLYFIT1');
% h1 = gcf;exportgraphics(h1,'sting22_SNR1.png')

%%%%%%%%%%%%%%%%%%
%        2       %
figure
plot(NBITS , SNR2)
hold on
plot(NBITS, poly2(1).*NBITS+poly2(2));
hold off
title('SNR2 / NBITS');xlabel('NBITS');ylabel('SNR(dB)'); 
legend('SNR2', 'POLYFIT2');
% h2 = gcf;exportgraphics(h2,'sting22_SNR2.png')

%%%%%%%%%%%%%%%%%%
%        3       %
figure
plot(NBITS , SNR3)
hold on
plot(NBITS, poly3(1).*NBITS+poly3(2));
hold off
title('SNR3 / NBITS');xlabel('NBITS');ylabel('SNR(dB)');
legend('SNR3', 'POLYFIT3');
% h3 = gcf;exportgraphics(h3,'sting22_SNR3.png')

%%%%%%%%%%%% CORR %%%%%%%%%%%%%%%
figure(6);
plot(NBITS, abs(CORRsin), '-x');
xlabel('NBITS');ylabel('y');
title('corrcoef(sigErro,sigSin)');
legend('abs(coeficientes correlação)');
h4 = gcf;exportgraphics(h4,'sin_corrcoef.png');
