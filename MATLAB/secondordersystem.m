%% RLC Circuit Analysis: Settling Time and Peak Time
clear; clc;

% 1. Define Component Values (Using our derived values)
R1 = 4.5;      % Ohms
R2 = 3000;    % Ohms
L  = .8;    % Henrys
C  = .02481;  % Farads (5 mF)

% 2. Calculate Intermediate Parameters (Based on your formulas)
% w_n^2 = (R1 + R2) / (L * R2 * C)
wn = sqrt((R1 + R2) / (L * R2 * C));

% 2 * zeta * wn = (R1 / L) + (1 / (R2 * C))
% Therefore: zeta = [(R1 / L) + (1 / (R2 * C))] / (2 * wn)
zeta = ((R1 / L) + (1 / (R2 * C))) / (2 * wn);

% 3. Calculate Performance Metrics using your provided formulas
Ts_calc = 4 / (zeta * wn);
Tp_calc = pi / (wn * sqrt(1 - zeta^2));

% 4. Create the Transfer Function Object: G(s) = num/den
% G(s) = [R2/(L*R2*C)] / [s^2 + ((R1*R2*C + L)/(L*R2*C))s + (R1+R2)/(L*R2*C)]
num = [R2 / (L * R2 * C)];
den = [1, ((R1*R2*C + L) / (L*R2*C)), ((R1 + R2) / (L * R2 * C))];
G = tf(num, den);

% 5. Automated Calculation using MATLAB's 'stepinfo'
info = stepinfo(G);

% --- Display Results ---
fprintf('--- Circuit Parameters ---\n');
fprintf('Natural Frequency (wn): %.4f rad/s\n', wn);
fprintf('Damping Ratio (zeta):   %.4f\n\n', zeta);

fprintf('--- Manual Formula Results ---\n');
fprintf('Settling Time (Ts):     %.4f s\n', Ts_calc);
fprintf('Peak Time (Tp):         %.4f s\n\n', Tp_calc);

fprintf('--- MATLAB stepinfo Results ---\n');
fprintf('Settling Time:          %.4f s\n', info.SettlingTime);
fprintf('Peak Time:              %.4f s\n', info.PeakTime);
% 6. Plot Step Response for Visualization
figure;
step(G);
grid on;
title(['Step Response: R1=', num2str(R1), ', R2=', num2str(R2), ', L=', num2str(L), ', C=', num2str(C)]);

