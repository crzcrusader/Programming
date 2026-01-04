% Clear workspace
clear; clc;

% Define complex numbers
z1 = 3 + j*5;    % Magnitude 5, angle ~53°
z2 = 10 + j*2;   % Magnitude sqrt(8), angle ~135°
z3 = -1 - 3j;   % Magnitude sqrt(10), angle ~ -108°
z4 = 2 - 1j;    % Magnitude sqrt(5), angle ~ -26°

% Combine into a vector
Z = [z1, z2, z3, z4];

% Plot using compass
figure;
compass(Z);

% Add title
title('Compass Plot of Complex Numbers');

O = ones(3,5)