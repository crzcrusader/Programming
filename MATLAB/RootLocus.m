clc; clear; close all;

% Define numerator and denominator
num = [1 3];   % (s + 3)

% Expand denominator: (s^2 +16s+10)(s+9)(s+4)
den1 = conv([1 16 10],[1 9]);
den = conv(den1,[1 4]);

% Root locus plot
figure;
rlocus(num, den);
grid on;
title('Root Locus of the System');

% Optional: mark imaginary axis
hold on;
xline(0,'--r');
%% 
syms s

K = -((s^2+16*s+10)*(s+9)*(s+4))/(s+2);
dK = diff(K, s);

solve(dK == 0, s)
%% 
syms s

K = -((s*(s^2+2)*(s+4)*(s+6))/(s+3));
dK = diff(K,s);

sol = solve(dK==0, s)
double(sol)

syms s K

poly = s^5 + 10*s^4 + 26*s^3 + 20*s^2 + (48+K)*s + 3*K;
routh_array = routh(poly)

%% 
clc; clear; close all;

% Transfer function
num = conv([1 2],[1 8]);   % (s+2)(s+8)
den = conv([1 0 0],[1 0 36]); % s^2(s^2+36)

figure;
rlocus(num, den);
grid on;
title('Root Locus');


syms s
K = -((s^2*(s^2+36))/((s+2)*(s+8)));
dK = diff(K,s);

break_pts = double(solve(dK==0,s));
disp('Breakaway candidates:')
disp(break_pts)

syms Ksym s

poly = s^4 + Ksym*s^2 + 10*Ksym*s + 16*Ksym + 36*s^2;
poly = expand(poly);

disp('Characteristic Polynomial:')
disp(poly)

