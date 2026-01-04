%Given V'(t) + 2V(t) = sin(t + arctan (1/2))
%initial conditions V(0) = 1
%from 1 to 10 

% Euler's Method for v' + 2v = sin(t + arctan(1/2))
clear; clc;

%  Parameters 
h = 0.01;
t = 0:h:10;
n = length(t);
theta = atan(1/2);  % arctan(1/2)

v_total = zeros(1, n);
v_comp = zeros(1, n);
v_particular = zeros(1, n);

%  Initial conditions 
v_total(1) = 1;
v_comp(1) = 1;   % v(0) = 1 for complementary
v_particular(1) = 0;  % will compute after

Vs = @(t) sin(t + theta);

%  Euler's Method for total solution 
for i = 1:n-1
    v_total(i+1) = v_total(i) + h * ( -2*v_total(i) + Vs(t(i)) );
end

%  Euler's Method for complementary (homogeneous) solution 
for i = 1:n-1
    v_comp(i+1) = v_comp(i) + h * (-2*v_comp(i));
end

%  Particular = total - complementary 
v_particular = v_total - v_comp;

%  Plotting 
plot(t, v_total, 'b', 'LineWidth', 2); hold on;
plot(t, v_comp, 'r--', 'LineWidth', 2);
plot(t, v_particular, 'g-.', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('v(t)');
title('Euler Method: Total, Complementary, and Particular Solutions');
legend('Total Solution', 'Complementary Solution', 'Particular Solution');
grid on;
%% % Solves V'' = -(1/2)V' - (7/4)V + Vs(t)
% Initial conditions: V(0) = 1, V'(0) = 0

clear; clc;


tspan = [0 20];
y0 = [1; 0];  % [V(0); V'(0)]

% Vs(t) = 2*u(t) 
Vs_a = @(t) 2 * (t >= 0);
odefun_a = @(t, y) [ y(2); -0.5*y(2) - 1.75*y(1) + Vs_a(t) ];
[t_a, Y_a] = ode23(odefun_a, tspan, y0);
v_dollar = Y_a(:,1);  % v$(t)

% Vs(t) = 100*sin(100*pi*t)*u(t)
Vs_b = @(t) 100 * sin(100*pi*t) .* (t >= 0);
odefun_b = @(t, y) [ y(2); -0.5*y(2) - 1.75*y(1) + Vs_b(t) ];
[t_b, Y_b] = ode23(odefun_b, tspan, y0);
v_paren = Y_b(:,1);  % v((t)

% Vs(t) = 2*u(t) + 100*sin(10*pi*t)*u(t)
Vs_c = @(t) 2 + 100 * sin(10*pi*t);
odefun_c = @(t, y) [ y(2); -0.5*y(2) - 1.75*y(1) + Vs_c(t) ];
[t_c, Y_c] = ode23(odefun_c, tspan, y0);
v_curly = Y_c(:,1);  % v)(t)

figure;
plot(t_a, v_dollar, 'b', 'LineWidth', 2); hold on;
plot(t_b, v_paren, 'r--', 'LineWidth', 2);
plot(t_c, v_curly, 'g-.', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('V(t)');
title('Solutions to V''''(t) = -0.5V'' - 1.75V + Vs(t)');
legend('v$(t): Vs = 2u(t)', ...
       'v((t): Vs = 100sin(100\pit)', ...
       'v)(t): Vs = 2 + 100sin(10\pit)', ...
       'Location', 'Best');
grid on;

%% % Solves: v'''' + 3v'' + 4v = 2*sin(2*pi*t)
% Initial conditions: v(0)=0, v'(0)=1, v''(0)=0, v'''(0)=0

clear; clc;

% Time range
tspan = [0 10];

% Initial conditions: [v, v', v'', v''']
y0 = [0; 1; 0; 0];

% Define the system as a first-order ODE
odefun = @(t, y) [
    y(2);                                      % y1' = y2
    y(3);                                      % y2' = y3
    y(4);                                      % y3' = y4
    -3*y(3) - 4*y(1) + 2*sin(2*pi*t)           % y4' = RHS
];

% Solve using ode23
[t, Y] = ode23(odefun, tspan, y0);

% Extract v(t) from solution
v = Y(:, 1);

% Plotting the solution
plot(t, v, 'b', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('v(t)');
xlim([0 10]);
title('Solution of 4th Order ODE using ode23');
grid on;

