clc;
clear;

% Given parameters
p = 3;                      % pole pairs
lambda_f = 35e-3;          % Wb
I = 12;                    % A

Ld = 3.52e-3;              % H
Lq = 1.12e-3;              % H

% Beta range (degrees)
beta_deg = 0:1:90;
beta = deg2rad(beta_deg);  % convert to radians

% Preallocate torque
Te = zeros(size(beta));

% Compute torque
for k = 1:length(beta)
    id = I * sin(beta(k));
    iq = I * cos(beta(k));
    
    Te(k) = (3/2)*p*( lambda_f*iq + (Ld - Lq)*id*iq );
end

% Plot
figure;
plot(beta_deg, Te, 'LineWidth', 2);
grid on;
xlabel('\beta (degrees)');
ylabel('Torque (Nm)');
title('PMSM Torque vs Current Advance Angle');