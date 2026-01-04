% Circuit Analysis Template in MATLAB

clear; clc;

% ===== Variables =====
Vs = 130;              % Voltage source magnitude (V)
f = 100;                % Frequency (Hz)
w = 2*pi*f;              % Angular frequency

R1 = 5;               % Resistor in ohms
R2 = 0;              % Another resistor if needed
L1 = 1.5;               % Inductance in Henrys
L2 = 0;
C = 0 ;             % Capacitance in Farads

% ===== Impedances =====
Z_R1 = R1;             % Resistor impedance
Z_R2 = R2;             
Z_L1 = 1j*w*L1;
Z_L2 = 0;
Z_C = -1j * 6;

% ===== Example Equivalent Circuits =====
% Series circuit: R1 + L + C
Z_eq1 = Z_R1 + Z_C;
Z_eq2 = Z_L1;


% Parallel example: R2 in parallel with C
Z_eq_parallel = (Z_eq1*Z_eq2)/(Z_eq1+Z_eq2);

% Total circuit impedance (example: series + parallel)
Z_total = Z_eq_parallel;

% ===== Voltage across capacitor =====



% ===== Current and Voltages =====
I_total = Vs / Z_total;         % Source current
I_Br1 = I_total * (Z_total/(Z_eq1 + Z_total));
I_Br2 = I_total* (Z_total/(Z_eq2 + Z_total));
V_C =  I_Br1 * Z_C;
V_R = I_Br1 * Z_R1;
V_L = I_Br2 * Z_L1;


% ===== Display Results =====
fprintf('Total Current: %.4f < %.4f \n', abs(I_total), (angle(I_total)));
fprintf('I_RC: %.4f < %.4f \n', abs(I_Br1), rad2deg(angle(I_Br1)));
fprintf('I_L: %.4f < %.4f \n', abs(I_Br2), rad2deg(angle(I_Br2)));
fprintf('Resistor Voltage: %.4f < %.4f \n', abs(V_R), rad2deg(angle(V_R)));
fprintf('Capacitor Voltage: %.4f < %.4f \n', abs(V_C), rad2deg(angle(V_C)));
fprintf('inductor Voltage: %.4f < %.4f \n', abs(V_L), rad2deg(angle(V_L)));

% ===== Compass Plot of Phasors =====
figure;
h = compass([V_R, V_L, V_C, I_total]);  % plot all phasors

% Customize appearance
set(h(1), 'Color', 'r', 'LineWidth', 2); % Resistor voltage in red
set(h(2), 'Color', 'b', 'LineWidth', 2); % Inductor voltage in blue
set(h(3), 'Color', 'g', 'LineWidth', 2); % Capacitor voltage in green
set(h(4), 'Color', 'y', 'LineWidth', 2); % Source voltage in black

title('Phasor Diagram of Voltages in RLC Series Circuit');
legend({'V_R','V_L','V_C','I_total'}, 'Location','bestoutside');