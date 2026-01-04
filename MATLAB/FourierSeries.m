% Fourier approximation of a periodic signal
T = 3;                  % Period
omega0 = 2*pi/T;        % Fundamental frequency
t = linspace(-3, 3, 1000);  % Time vector over two periods

% Coefficients
C1 = 16/pi;
C3 = -16/(3*pi);
C5 = 16/(5*pi);

% Signal approximation
s_hat = 4 + ...
        C1*cos(omega0*t) + ...
        C3*cos(3*omega0*t) + ...
        C5*cos(5*omega0*t);

% Plotting
figure;
plot(t, s_hat, 'LineWidth', 2);
xlabel('Time t');
ylabel('ŝ(t)');
title('Fourier Series Approximation of s(t)');
grid on;
