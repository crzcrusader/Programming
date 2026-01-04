% average_function.m
% Script to compute the average of a continuous function f(x) over [a, b]

clear; clc; close all;

% --- Define the function f(x) here ---
syms x
f(x) = x*log(x^2)+2;   % Example: change this to any f(x)

% --- Define the interval [a, b] ---
a = exp(1);        % lower limit
b = (exp(1))^2f;       % upper limit

% --- Compute the integral ---
integral_value = int(f(x), x, a, b);

% --- Compute the average ---
f_avg = (1/(b-a)) * integral_value;

% --- Display results ---
disp('Function f(x):');
disp(f(x));
disp(['Interval: [', num2str(a), ', ', num2str(b), ']']);
disp(['Integral of f(x) = ', char(vpa(integral_value, 6))]);
disp(['Average value of f(x) = ', char(vpa(f_avg, 6))]);

% --- Optional: Plot the function ---
fplot(f, [a b], 'LineWidth', 2)
title('Function f(x) over [a,b]')
xlabel('x'); ylabel('f(x)');
grid on
