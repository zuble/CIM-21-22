    
% EEC0051 - PROCESSAMENTO E CODIFICACAO DE INFORMACAO MULTIMEDIA
%
% first home assignment
%
% due date: February 19, 2021
%
% AnIbal Ferreira

close all;
clear all;
clc;

%{
% AUDIO PART
NBITS = 16;
% in case you have a MORE recent version of Matlab, you might need to use:
[x,FS]=audioread('sting22.wav');
%[x,FS,NBITS]=wavread('sting22.wav'); % old Matlab versions 
%sound(x,FS,NBITS); % NOTA: x values are already in the range [-1, 1]
samples=[0:length(x)-1];
figure(1)
plot(samples/FS, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('sting22.wav');

% insert code here

B=[2 4 6 8 10 12 14];
x_quant = x.*(2 .^ (B-1));
x_quant = floor(x_quant + 0.5);
x_quant = x_quant ./ (2 .^ (B-1));
error = x_quant - x;
SNR = 10 .* log10(var(x_quant) ./ var(error));
p = polyfit(B, SNR, 1);
%sound(x_quant(:, 3), FS, NBITS);

figure(2)
plot(samples/FS, error);
xlabel('Time (s)');
ylabel('Amplitude');
title('Quantization Error');

%Alinea 1
figure(3)
plot(B, SNR, 'x');
hold on
plot(B, p(1).*B+p(2));
hold off
xlabel('Número de Bits');
ylabel('Valor (dB)');
title('SNR');
legend('SNR do sinal', 'Regressão linear');

%Alinea 2
c = zeros(1,length(B));

for n = 1:length(B)
    aux = corrcoef(error(:,n), x);
    c(n) = aux(2,1);
end

figure(4)
plot(B, abs(c), '-x');
xlabel('Número de Bits');
ylabel('Valor');
title('Correlação Cruzada Normalizada');
legend('Valor absoluto dos coeficientes de correlação');

%}
% IMAGE PART

% reads and displays image
A=imread('lena512.bmp');
figure(5)
imshow(A,[0 255]); % displays original image
A=single(A)/255.0; % convert to float and normalizes [0, 1.0]
title('lena512.bmp');


% insert code here
B_img=[2 3 4 5 6 7 8];
A_quant = zeros(length(A), length(A), length(B_img));
error_A = A_quant;

for n=1:length(B_img)
    aux = A .* (2.^(B_img(n)-1));
    aux = floor(aux + 0.5);
    aux = aux ./ (2 .^ (B_img(n)-1));
    A_quant(:, :, n) = aux;
    imshow(A_quant(:, :, n));
    error_A(:, :, n) = aux - A;
end

SNR_img = 10 .* log10(var(A_quant, 0, [1, 2]) ./ var(error_A, 0, [1, 2]));

SNR_img = reshape(SNR_img, [1,7]);

p_img = polyfit(B_img, SNR_img, 1);

Ar=uint8(A_quant(:, :, 5)*255.0); % convert to "uint" format
figure(6);
imshow(Ar,[0 255]); % displays modified image
title('modified Lena');


%Alinea 4
figure(7)
plot(B_img, SNR_img, 'x');
hold on
plot(B_img, p_img(1).*B_img+p_img(2));
hold off
xlabel('Número de Bits');
ylabel('Valor (dB)');
title('SNR');
legend('SNR do sinal', 'Regressão linear');

%{
%Alinea 6
samples_sinal=[0:499];
sinal =sin(0.22*samples_sinal);
B_sinal = B_img;
sinal_quant = transpose(sinal) .* (2 .^ (B_sinal-1));
sinal_quant = floor(sinal_quant + 0.5);
sinal_quant = sinal_quant ./ (2 .^ (B_sinal-1));
erro_sinal = sinal_quant - transpose(sinal);
SNR_sinal = 10 .* log10(var(sinal_quant) ./ var(erro_sinal));
%SNR_teorico = 10.*log10((2.^(2*B))./6);    
SNR_teorico = 6.02.*B_sinal + 7.8;

figure(8)
plot(B_sinal, SNR_sinal, '-x');
hold on
plot(B_sinal, SNR_teorico, '-x');
hold off
xlabel('Número de Bits');
ylabel('Valor (dB)');
title('SNR');
legend('SNR do sinal', 'SNR teórico');

%Alinea 7
F=[2 4];
h2=ones(F(1), 1);
h4=ones(F(2), 1);
x_sampled = downsample(x, F(2));
x_sampled = upsample(x_sampled, F(2));
x_sampled = filter(h4, 1, x_sampled);
figure(9)
plot(samples/FS, x_sampled);
xlabel('Time (s)');
ylabel('Amplitude');
title('sting22 sampled');
%}