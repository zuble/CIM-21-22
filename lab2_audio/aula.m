clear all;
close all;
clc;

%rand : ruido pdf uniforme
%randn : ruio com pdf gaussiana

n = 0:1:100000;
seno = sin(0.3*n);
histogram(seno,50);                    %PDF
pwelch(seno,hanning(1024),512,1024);


x = seno + 0.75*randn(1,length(seno));
figure;histogram(x,50);  %PDF
figure;pwelch(x,hanning(1024),512,1024);


x1 = rand(1,length(seno)-0.5);
figure;histogram(x1,50);                    %PDF
figure;pwelch(x1,hanning(1024),512,1024);   %Welch’s power spectral density estimat

x2 = rand(1,length(seno)-0.5);
x2 = x2 + x1;
figure;histogram(x2,50);                    %PDF
figure;pwelch(x2,hanning(1024),512,1024);

x3 = rand(1,length(seno)-0.5);
x3 = x3 + x2;
figure;histogram(x3,50);                    %PDF
figure;pwelch(x3,hanning(1024),512,1024);

%{
soma de sinais com pdf arbitarias mas se o sinais forem estacionarios , 
media e variancaia finitas,
resulta nnuma tendencia para gaussiana
lei da natureza


pdf independente com psd cas a psd consista em tuido branco
funcao de autocorrelacao = impulso
resulta uma psd flat e pdf arbitraria1
transformada fourier impulso é plana


psd nao plana = pdf alguma forma condicionada
sinoisde caso mais forte 


sinal com estrutura espetral nao pode ter pdf arbitraria

pdf ruido é plana 

%}