%% PV Module I-V Curve (Single-diode with Rs and Rp) -- NO FSOLVE
% Given:
%   Ns = 72
%   Rs_cell = 0.001 ohm, Rp_cell = 10 ohm
%   Vd = 0.57 V per cell (interpreted as Voc per cell)
%   Isc = 5.73 A

clear; clc; close all;

%% ---- Inputs ----
Ns = 72;
T_C = 25;
T_K = T_C + 273.15;

Vd_cell = 0.57;          % [V] per cell (assumed Voc per cell)
Voc = Ns * Vd_cell;      % [V] module Voc

Isc = 5.73;              % [A] module Isc

Rs_cell = 0.001;         % ohm per cell
Rp_cell = 10.0;          % ohm per cell

Rs = Ns * Rs_cell;       % module series resistance
Rp = Ns * Rp_cell;       % module shunt resistance

n = 1.30;                % diode ideality factor (adjust if your course specifies)

%% ---- Constants ----
k = 1.380649e-23;
q = 1.602176634e-19;

Vt_cell = k*T_K/q;           % thermal voltage per cell
Vt_mod  = n * Ns * Vt_cell;  % n*Ns*Vt

%% ---- Solve I0 and IL algebraically from Voc and Isc ----
% Model: I = IL - I0*(exp((V + I*Rs)/Vt_mod) - 1) - (V + I*Rs)/Rp
%
% At open circuit (I=0, V=Voc):
%   IL = I0*(exp(Voc/Vt_mod)-1) + Voc/Rp
%
% At short circuit (I=Isc, V=0):
%   Isc = IL - I0*(exp(Isc*Rs/Vt_mod)-1) - Isc*Rs/Rp
%
% Substitute to get I0:
num = Isc - Voc/Rp + (Isc*Rs)/Rp;
den = exp(Voc/Vt_mod) - exp((Isc*Rs)/Vt_mod);

I0 = num / den;
IL = I0*(exp(Voc/Vt_mod)-1) + Voc/Rp;

fprintf('Using Voc = %.3f V, Isc = %.3f A\n', Voc, Isc);
fprintf('Solved parameters (no fsolve):\n');
fprintf('  n  = %.3f\n', n);
fprintf('  I0 = %.6e A\n', I0);
fprintf('  IL = %.6f A\n', IL);
fprintf('  Rs = %.6f ohm, Rp = %.6f ohm\n', Rs, Rp);

%% ---- Compute I-V curve using Newton-Raphson for implicit I(V) ----
Npts = 600;
V = linspace(0, Voc, Npts);
I = zeros(size(V));

maxIter = 80;
tol = 1e-10;

for idx = 1:numel(V)
    Vk = V(idx);

    % Good initial guess
    Ik = Isc * max(0, 1 - Vk/Voc);

    for it = 1:maxIter
        arg = (Vk + Ik*Rs)/Vt_mod;
        expa = exp(arg);

        f  = IL - I0*(expa - 1) - (Vk + Ik*Rs)/Rp - Ik;
        df = -I0*expa*(Rs/Vt_mod) - (Rs/Rp) - 1;

        dI = -f/df;
        Ik = Ik + dI;

        if abs(dI) < tol
            break;
        end
    end

    I(idx) = max(Ik, 0); % clamp small negatives
end

%% ---- Plot I-V curve ----
figure;
plot(V, I, 'LineWidth', 2);
grid on;
xlabel('Module Voltage V (V)');
ylabel('Module Current I (A)');
title('PV Module I-V Characteristic (Single Diode + Rs + Rp)');