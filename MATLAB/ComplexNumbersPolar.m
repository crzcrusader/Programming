% Complex Number Operations Script
% Accepts Z1, Z2, Z3 and performs operations a, b, c
% Displays results in polar form

clear; clc;

% ---- INPUTS ----
Z1 = -3+2j;
Z2 = 1-2j;
Z3 = 0

% ---- OPERATIONS ----
a = Z1*Z2;        % Example: addition
b = Z1/conj(Z2);        % Example: multiplication
c = Z1^2;        % Example: division
d = Z1*conj(Z1);

% ---- DISPLAY RESULTS ----
disp(' ');
disp('--- Results in Polar Form ---');

% Function to display polar form
showPolar = @(Z,name) fprintf('%s = %.3f ∠ %.3f rad (%.2f°)\n',...
    name, abs(Z), angle(Z), rad2deg(angle(Z)));

showPolar(Z1,'Z1 = ');
showPolar(Z2,'Z2 = ');
showPolar(a,'a = Z1*Z2');
showPolar(b,'b = Z1/Z2`');
showPolar(c,'c = Z1^2`');
showPolar(d,'d = Z1*Z1`');


