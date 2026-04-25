%% Problem 5.8 - 4 module array (2S south @1-sun) || (2S west @0.5-sun)
clear; clc; close all;

%% ---- Given / read from figure ----
Imp_1sun = 4;       % A  (MPP current of ONE module at 1-sun)
Vmp_1sun = 40;      % V  (MPP voltage of ONE module at 1-sun)

% You must estimate Voc from the plot (knee is just above 40 V).
Voc_1sun = 42;      % V  <-- adjust if your book shows a different Voc

% Irradiances
G_south = 1000;     % W/m^2 (1-sun)
G_west  = 500;      % W/m^2 (0.5-sun)

%% ---- Scale current with irradiance (voltage ~ constant assumption) ----
scale_s = G_south/1000;
scale_w = G_west /1000;

Imp_s = Imp_1sun * scale_s;     % 4 A
Imp_w = Imp_1sun * scale_w;     % 2 A

Vmp_s = Vmp_1sun;               % assume unchanged
Vmp_w = Vmp_1sun;

Voc_s = Voc_1sun;               % assume unchanged
Voc_w = Voc_1sun;

%% ---- Build module I(V) function (piecewise) ----
I_module = @(V, Imp, Vmp, Voc) ...
    (V <= Vmp).*Imp + ...
    (V >  Vmp & V <= Voc).* (Imp .* (Voc - V)./(Voc - Vmp)) + ...
    (V > Voc).*0;

%% ---- Two modules in series per string ----
% If both modules in a string are identical and see same irradiance,
% then V_string = 2*V_module  =>  V_module = V_string/2
% and I_string(V_string) = I_module(V_string/2)

I_string_south = @(Vstr) I_module(Vstr/2, Imp_s, Vmp_s, Voc_s);
I_string_west  = @(Vstr) I_module(Vstr/2, Imp_w, Vmp_w, Voc_w);

%% ---- Two strings in parallel (array) ----
% Parallel: same voltage, currents add
I_array = @(V) I_string_south(V) + I_string_west(V);

%% ---- Sweep voltage and compute I(V), P(V) ----
Vmax_array = 2*Voc_1sun;              % approx array Voc (strings share same Voc)
V = linspace(0, Vmax_array, 1000);
I = arrayfun(I_array, V);
P = V .* I;

% Find MPP numerically
[Pmp, idx] = max(P);
Vmp_array = V(idx);
Imp_array = I(idx);

%% ---- Plot I-V curve (array) ----
figure;
plot(V, I, 'LineWidth', 2);
% Make axes larger so curve fills graph better
xlim([0 100]);      % expand voltage axis
ylim([0 8]);        % expand current axis

% Optional: make grid more visible
set(gca,'FontSize',12);
grid on;
xlabel('Array Voltage (V)');
ylabel('Array Current (A)');
title('Array I-V Curve: (2S @1-sun) || (2S @0.5-sun)');
hold on;
plot(Vmp_array, Imp_array, 'o', 'MarkerSize', 8, 'LineWidth', 2);
text(Vmp_array+1, Imp_array, sprintf('MPP: %.1f V, %.1f A', Vmp_array, Imp_array));

%% ---- Print results ----
fprintf('Array MPP results (from curve):\n');
fprintf('  Vmp_array = %.3f V\n', Vmp_array);
fprintf('  Imp_array = %.3f A\n', Imp_array);
fprintf('  Pmp_array = %.2f W\n', Pmp);

% Also print the "by-hand expected" estimate:
fprintf('\nQuick estimate (assuming both strings near MPP at ~80V):\n');
fprintf('  P ~ 80V * (4A + 2A) = 480 W\n');