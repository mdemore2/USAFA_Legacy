function y = voice_removal_lpf2(x, h)
% y = voice_removal_lpf2(x, h);
% A voice removal Algorithm
%       Simplify to one LPF, a subtractor, and an adder
%       x is assumed to be a two channel signal (left and right)
%       h is impulse response of LPF filter
%
%      Plots only scaled right if N = 48000 (1 sec)
%
% By George York
%     Copyright (c) 2003 by George W.P. York
%
fs = 48000.0;
N = length(h);
% low pass filter both channels
x_left_LPF = conv(x(:,1),h);
% subtract left and right channels
left_right = x(:,1) - x(:,2);
% Add bass back...  and handle group delay
y = left_right + x_left_LPF(((N/2)+1):(length(left_right)+(N/2)));

% plotting section
N=length(x(:,1));
n2=1:((N/4)+2);
n3=0:((N/4)+1);
n3= n3*fs/N;
figure(1)
subplot(3,1,1);
leftplot = abs(fft(x(:,1))).*(2/N);
stem(n3,leftplot(n2));
xlabel('frequency (Hz)')
ylabel('Left Channel')
subplot(3,1,2);
rightplot = abs(fft(x(:,2))).*(2/N);
stem(n3,rightplot(n2));
xlabel('frequency (Hz)')
ylabel('Right Channel')
subplot(3,1,3);
outplot = abs(fft(y)).*(2/N);
stem(n3,outplot(n2));
xlabel('frequency (Hz)')
ylabel('Ideal Output')

figure(2);
n2=1:((N/80)+2);
n3=0:((N/80)+1);
n3= n3*fs/N;
subplot(3,1,1);
leftplot = abs(fft(x(:,1))).*(2/N);
stem(n3,leftplot(n2));
xlabel('frequency (Hz)')
ylabel('Left Channel')
subplot(3,1,2);
rightplot = abs(fft(x(:,2))).*(2/N);
stem(n3,rightplot(n2));
xlabel('frequency (Hz)')
ylabel('Right Channel')
subplot(3,1,3);
outplot = abs(fft(y)).*(2/N);
stem(n3,outplot(n2));
xlabel('frequency (Hz)')
ylabel('Ideal Output')
