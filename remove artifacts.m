
%Design a frequency-domain filter to remove periodic artifacts,such as
%power-line interference.

% Use this program to read the files ECG31.dat
tic
clc;
clear all;
fs=1000;  %sampling frequency
t=[1/fs:1/fs:4]; %time duration
x0=reshape(load('C:\Users\Vivek Prajapati\Documents\MATLAB/ecg31.dat'),1,4000)-2000; 
% x0=sin(2*pi*6*t);
% x0 =ecg(40000);

fr=50;
x1=500*sin(2*pi*fr*t);  %sinusoidal
%original+sinusoidal
x=x0+x1;

figure(1);
subplot 221;
plot(x0);
% xlim([0 500]);
title('Original');
subplot 222;
plot(x1);
% xlim([0 500]);
title('Sine - %d Hz');

subplot 223;
plot(x);
% xlim([0 500]);
title('Original+Sine');

fm=fs/2;%Nyquist
f1=50;%Notch freq.
fc=f1/fm;%Normalized
bw=(f1/fs);

%Notch filter
[num,den]=iirnotch(fc,0.0377);%,bw);
h=dfilt.df2(num,den);
y=filter(h,x);

subplot 224;
plot(y);
% xlim([0 500]);
title('Filtered')

%magnitude response of notch
fvtool(num,den);
%[phi,w]]=phasez(b,a);
phasez(num,den);%phase response of notch
toc  % Read elapsed time from stopwatch