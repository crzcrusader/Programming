% Define time vector
t = -5:0.01:5;   % Time from -5 to 5 in steps of 0.01

% Define step function u(t-1)
u = double(t >= 1);   % Step starts at t = 1

% Plot the step function
plot(t, u, 'LineWidth', 2);
grid on;
xlabel('Time (t)');
ylabel('u(t - 1)');
title('Unit Step Function u(t - 1)');
ylim([-0.2, 1.2]);     % Make step more visible
