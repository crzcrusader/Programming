% Parameters
Ra = 0.2;
Vt_a = 220; Vt_d = 180;
Ia_nom = 74;
KaPhi_nom = 1.7038;
T_load = 126.08;

% Speed ranges (rad/s)
w = 0:1:160;

% Torque Equations: T = (KaPhi/Ra) * (Vt - KaPhi*w)
T_a = (KaPhi_nom/Ra) * (Vt_a - KaPhi_nom * w);
T_b = (0.8*KaPhi_nom/Ra) * (Vt_a - 0.8*KaPhi_nom * w);
T_d = (KaPhi_nom/Ra) * (Vt_d - KaPhi_nom * w);

% Plotting
figure;
plot(w, T_a, 'b', 'LineWidth', 1.5); hold on;
plot(w, T_b, 'r', 'LineWidth', 1.5);
plot(w, T_d, 'g', 'LineWidth', 1.5);
yline(T_load, '--k', 'Load Torque');

% Operating Points
plot(120.43, T_load, 'bo', 'MarkerFaceColor', 'b'); % Point A
plot(147.8, T_load, 'ro', 'MarkerFaceColor', 'r');  % Point B
plot(96.96, T_load, 'go', 'MarkerFaceColor', 'g');  % Point D

grid on;
xlabel('Speed \omega_m (rad/s)'); ylabel('Torque (N-m)');
legend('Case A (Nominal)', 'Case B (Flux -20%)', 'Case D (Voltage 180V)');
title('DC Motor Torque-Speed Characteristics');