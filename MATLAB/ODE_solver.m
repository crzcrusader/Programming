% Euler's Method for solving: v'' + 4v' + 2v = [cos(4t)]^3 * u(t)

clear; clc;

% ---- Parameters ----
h = 0.1;       % Step size
t0 = 0;          % Initial time
tf = 5;          % Final time

% ---- Initial conditions ----
v0 = 5;          % v(0)
vp0 = 2;         % v'(0)

% ---- Time vector ----
t = t0:h:tf;
n = length(t);

% ---- Initialize arrays ----
v = zeros(1, n);      % Position: v(t)
vp = zeros(1, n);     % Velocity: v'(t)

% ---- Set initial values ----
v(1) = v0;
vp(1) = vp0;

% ---- Forcing function and differential equation ----
forcing = @(t) (cos(4*t)).^3 .* (t >= 0);          % Right-hand side
f = @(t, v, vp) -4*vp - 2*v + forcing(t);          % v'' = ...

% ---- Euler's Method Loop ----
for i = 1:n-1
    v(i+1) = v(i) + h * vp(i);
    vp(i+1) = vp(i) + h * f(t(i), v(i), vp(i));
end

% ---- Output first 5 time steps ----
fprintf(' Step |    t (s)   |   v(t)    |   v''(t)\n');
fprintf('------------------------------------------\n');
for i = 1:5
    fprintf('  %2d  |  %8.4f  | %8.5f | %8.5f\n', i-1, t(i), v(i), vp(i));
end

