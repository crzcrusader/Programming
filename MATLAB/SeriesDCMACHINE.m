clc;
clear;
close all;

% Given values
V = 250;
Ra = 2;
Rf = 5;
R = Ra + Rf;
Kf = 0.22;

k = -2;
T0 = 200;

% Speed range (rad/s)
w = linspace(0, 200, 1000);

% Motor torque
I = V ./ (R + Kf .* w);
Tm = Kf .* I.^2;

% Load torque
Tl = k .* w + T0;

% Plot
figure;
plot(w, Tm, 'b', 'LineWidth', 2); hold on;
plot(w, Tl, 'r--', 'LineWidth', 2);

xlabel('\omega (rad/s)');
ylabel('Torque (Nm)');
title('Torque-Speed Characteristics');
legend('Motor Torque', 'Load Torque');
grid on;
%% % Coefficients
V = 250;
R = 7;
Kf = 0.22;

k = -2;
T0 = 200;

a2 = Kf^2;
a1 = 2*R*Kf;
a0 = R^2;

A = k * a2;
B = k * a1 + T0 * a2;
C = k * a0 + T0 * a1;
D = T0 * a0 - Kf * V^2;

coeffs = [A B C D];

% Solve roots
w_roots = roots(coeffs)

I_roots = V ./ (R + Kf .* w_roots);
T_roots = Kf .* I_roots.^2;

disp('Operating points (omega, Torque):');
disp([w_roots T_roots]);


%% % Numerical derivative of motor torque
dTm_dw = gradient(Tm, w);

for i = 1:length(w_roots)
    if isreal(w_roots(i))
        slope_motor = interp1(w, dTm_dw, w_roots(i));
        slope_load = k;

        fprintf('\nOperating point %d:\n', i);
        fprintf('omega = %.2f rad/s\n', w_roots(i));
        fprintf('Motor slope = %.4f\n', slope_motor);
        fprintf('Load slope = %.4f\n', slope_load);

        if slope_motor < slope_load
            fprintf('→ STABLE\n');
        else
            fprintf('→ UNSTABLE\n');
        end
    end
end
