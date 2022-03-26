%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%   SIN   %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;
clear all;
clc;

samples=[0: 1E5-1];
sigsin=sin(0.22*samples);
figure(1);subplot(7,2,1);
plot(samples,sigsin), grid on
xlabel('Samples');ylabel('Amp');legend('sin');

NBITS = [2:1:14];
SNRsin1 = zeros(1,length(NBITS)); 
SNRsin2 = zeros(1,length(NBITS));
SNRsin3 = zeros(1,length(NBITS));
CORRsin = zeros(1,length(NBITS));

% original PDF
figure(2);subplot(7,2,1);
[H1 X1]=hist(sigsin,50); equalize1=50/(max(sigsin)-min(sigsin));
bar(X1, H1/sum(H1)*equalize1, 0.5);
ylabel('PDF'); xlabel('x[n] amplitude'); legend('PDFsin');


for i = 1:length(NBITS)
  
    n = num2str(NBITS(i));

    sigsinQ2 = sigsin.*(2 .^ (NBITS(i)-1));
    sigsinQ2 = floor(sigsinQ2 + 0.5);
    sigsinQ2 = sigsinQ2 ./ (2 .^ (NBITS(i)-1));
    
    
    % Quant waveform
    figure(1);subplot(7,2,i+1);
    plot(samples,sigsinQ2)
    xlabel('Samples');ylabel('Amp');
    leg=strcat('sinQ',n);legend(leg);


    %%%%%%%
    % SNR %
    sigsinE2 = sigsinQ2 - sigsin;
    
    SNRsin1(i) = snr(sigsin,sigsinE2);
    SNRsin2(i) = 10 * log10(var(sigsinQ2) / var(sigsinE2));
    SNRsin3(i) = 10 * log10( mean( sigsin .^ 2 ) / mean( sigsinE2 .^ 2 ) );
    
    
    %%%%%%%%
    % CORR %
    aux = corrcoef(sigsinE2, sigsin);
    CORRsin(i) = aux(1,2);
    
    %%%%%%%
    % PDF %
    figure(2);subplot(7,2,i+1);
    [H2 X2]=hist(sigsinE2,50); equalize2=50/(max(sigsinE2)-min(sigsinE2));
    bar(X2, H2/sum(H2)*equalize2, 0.5);
    ylabel('PDF'); xlabel('x[n] amplitude');
    leg=strcat('sinErroQ',n,'PDF'); legend(leg);
end


%%%%%%%%%%%% SNR %%%%%%%%%%%%%%%
poly1 = polyfit(NBITS, SNRsin1, 1);poly2 = polyfit(NBITS, SNRsin2, 1);poly3 = polyfit(NBITS, SNRsin3, 1);
SNRref = 6.02 .* NBITS + 7.8;

%%%%%%%%%%%%%%%%%%
%        1       %
figure(3);
plot(NBITS , SNRsin1,'-x')
hold on
plot(NBITS, SNRref);
hold off
title('SNRsin1 / NBITS');xlabel('NBITS');ylabel('SNR(dB)');
legend('SNRsin1', 'SNRref');
% h1 = gcf;
% exportgraphics(h1,'SNRsin1.png')

%%%%%%%%%%%%%%%%%%
%        2       %
figure(4)
plot(NBITS , SNRsin2)
hold on
plot(NBITS , SNRref);
hold off
title('SNRsin2 / NBITS');xlabel('NBITS');ylabel('SNR(dB)');
legend('SNRsin2', 'SNRref');
% h2 = gcf;exportgraphics(h2,'SNRsin2.png')


%%%%%%%%%%%%%%%%%%
%        3       %
figure(5)
plot(NBITS , SNRsin3);
hold on
plot(NBITS , SNRref);
hold off
title('SNRsin3 / NBITS');xlabel('NBITS');ylabel('SNR(dB)');
legend('SNRsin3', 'SNRref');
% h3 = gcf;exportgraphics(h3,'SNRsin3.png')


%%%%%%%%%%%% CORR %%%%%%%%%%%%%%%
figure(6);
plot(NBITS, abs(CORRsin), '-x');
xlabel('NBITS');ylabel('y');
title('corrcoef(sigErro,sigSin)');
legend('abs(coeficientes correlação)');
h4 = gcf;exportgraphics(h4,'sin_corrcoef.png');
