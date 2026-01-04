% Euler's Method for solving: v'(t) + 5v(t) = t*cos(9*t^2)*u(t)
% Outputs the first 5 steps (no plot)

clear; clc;

% ---- Parameters ----
h = 0.1;         % Step size
t0 = 0;            % Initial time
tf = 1;            % Final time

% ---- Initial condition ----
v0 = 2;            % v(0) — you can change this

% ---- Time vector ----
t = t0:h:tf;
n = length(t);

% ---- Initialize v(t) ----
v = zeros(1, n);
v(1) = v0;

% ---- Define RHS of the ODE: v' = -5v + t*cos(9t^2)
f = @(t, v) -5*v + t .* cos(9*t.^2);

% ---- Euler's Method Loop ----
for i = 1:n-1
    v(i+1) = v(i) + h * f(t(i), v(i));
end

% ---- Output first 5 steps ----
fprintf(' Step |    t (s)   |   v(t)\n');
fprintf('-------------------------------\n');
for i = 1:5
    fprintf('  %2d  |  %8.4f  | %8.5f\n', i-1, t(i), v(i));
end
