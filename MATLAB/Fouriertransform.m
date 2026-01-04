t = 0:0.001:1;
x = sin(2*pi*10*t) + 0.5*sin(2*pi*30*t); % 10 Hz and 30 Hz signal
X = fft(x);
f = (0:length(X)-1)*(1/(t(end)-t(1)))/length(X);

% Plot magnitude of frequency components
plot(f, abs(X));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Fourier Transform of Signal');
xlim([0 100]);
