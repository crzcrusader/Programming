% Sinusoidal wave traveling in -x direction
% y(x,t) = 40*cos((pi/15)*x + 20*pi*t + pi/4), units: cm

clear; clc;

% Parameters
A = 40;              % amplitude (cm)
lambda = 30;         % wavelength (cm)
f = 10;              % frequency (Hz)
k = 2*pi/lambda;     % wavenumber (rad/cm)
omega = 2*pi*f;      % angular frequency (rad/s)
phi = pi/4;          % phase (rad)

% Spatial axis (0 to 90 cm for 3 wavelengths)
x = linspace(0, 90, 500); 

% --- 1. Plot snapshots of the wave at different times ---
t_values = [0, 0.01, 0.02, 0.03]; % times in seconds
figure;
hold on;
colors = lines(length(t_values));

for i = 1:length(t_values)
    t = t_values(i);
    y = A*cos(k*x + omega*t + phi);
    plot(x, y, 'Color', colors(i,:), 'LineWidth', 1.5, ...
         'DisplayName', sprintf('t = %.2f s', t));
end

title('Snapshots of Traveling Wave');
xlabel('x (cm)');
ylabel('y(x,t) (cm)');
legend('show');
grid on;
hold off;

% --- 2. Animate the wave ---
figure;
for t = 0:0.002:.5  % animate for 0.1 s
    y = A*cos(k*x + omega*t + phi);
    plot(x, y, 'b-', 'LineWidth', 2);
    axis([0 90 -A A]);
    xlabel('x (cm)');
    ylabel('y(x,t) (cm)');
    title(sprintf('Traveling Wave at t = %.3f s', t));
    grid on;
    drawnow;
end

