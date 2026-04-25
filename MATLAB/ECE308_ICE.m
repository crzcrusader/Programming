%% Root Locus for:
% L(s) = K*(s+4)/((s+1)(s+2)(s+8)(s+9)(s+10))

clear; clc; close all;

s = tf('s');

% Open-loop transfer function (K handled automatically by rlocus)
L = (s + 4) / ((s+1)*(s+2)*(s+8)*(s+9)*(s+10));

figure('Color','w');
rlocus(L);
grid on;
title('Root Locus');
xlabel('Real Axis');
ylabel('Imag Axis');
hold on;

%% Manually plot poles and zeros (fixes your error)

p = pole(L);
z = zero(L);

plot(real(p), imag(p), 'x', ...
    'MarkerSize', 10, 'LineWidth', 2);

plot(real(z), imag(z), 'o', ...
    'MarkerSize', 10, 'LineWidth', 2);

%% Plot centroid and asymptotes

centroid = -6.5;  % previously calculated
xline(centroid,'--','Centroid = -6.5');

angles = [45 135 225 315]*pi/180;
R = 50;  % length of asymptote lines

for th = angles
    x = [centroid, centroid + R*cos(th)];
    y = [0,        0        + R*sin(th)];
    plot(x,y,'--');
end

%% Plot break-away points

breakPts = [-9.585, -1.499];
plot(breakPts, [0 0], 'kp', ...
    'MarkerSize', 12, 'MarkerFaceColor','y');

hold off;