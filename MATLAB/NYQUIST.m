%% Nyquist Plot Analysis Script
clear; clc; close all;

% 1. Define your Transfer Function G(s)H(s)
% Example: G(s) = 10 / (s^2 + 2s + 2)
% For G(s) = 10 / (s(s+1)(s+2)), use: num = 10; den = conv([1 0], conv([1 1], [1 2]));
num = [1 -2];              % Numerator coefficients
den = [1 6 14 8];         % Denominator coefficients (e.g., s^3 + 3s^2 + 2s)

sys = tf(num, den);

% 2. Generate the Nyquist Plot Data
[re, im, w] = nyquist(sys);

% Reshape the data (Matlab returns 3D arrays for MIMO, we need 1D for plotting)
re = squeeze(re);
im = squeeze(im);

% 3. Create the Visualization
figure('Color', 'w', 'Name', 'Nyquist Diagram Analysis');
hold on; grid on;

% Plot the Nyquist Path
plot(re, im, 'b-', 'LineWidth', 2, 'DisplayName', 'Nyquist Path (\omega > 0)');
plot(re, -im, 'b--', 'LineWidth', 1, 'DisplayName', 'Mirror Path (\omega < 0)');

% 4. Mark the Critical Point (-1, 0)
plot(-1, 0, 'rx', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', 'Critical Point (-1, 0)');

% 5. Add Directional Arrows (to show transformation from start to finish)
% We pick a few points in the middle of the frequency range to place arrows
idx = round(length(re) * 0.1); % Adjust index for arrow placement
annotation('arrow', 'X', [0.5 0.51], 'Y', [0.5 0.51]); % Dummy for legend logic
quiver(re(idx), im(idx), re(idx+1)-re(idx), im(idx+1)-im(idx), 0, 'MaxHeadSize', 2, 'Color', 'b');

% 6. Identify Axis Crossings
% Find where imaginary part is close to zero (Real axis crossing)
[~, real_idx] = min(abs(im(w > 0.01))); % Ignore origin
real_crossing = re(real_idx);
fprintf('The Nyquist plot crosses the Real Axis at: %.3f\n', real_crossing);

% 7. Final Formatting
xlabel('Real Axis (Re)');
ylabel('Imaginary Axis (Im)');
title('Nyquist Diagram with Direction and Critical Point');
legend('Location', 'best');
axis equal; % Important for seeing true angles

% Draw Unit Circle for Gain Margin reference
th = 0:pi/50:2*pi;
plot(cos(th), sin(th), 'k:', 'HandleVisibility', 'off'); 

hold off;