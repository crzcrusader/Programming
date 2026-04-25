% Define the transfer function: G(s)H(s) = 1 / [s(s-4)(s+8)(s+10)]
zeros = [];
poles = [0, 4, -8, -10];
gain = 1;

sys = zpk(zeros, poles, gain);

% Generate the Nyquist Plot
figure;
nyquist(sys);
grid on;

% Labeling for clarity
title('Nyquist Plot: G(s)H(s) = 1 / [s(s-4)(s+8)(s+10)]');
xlabel('Real Axis');
ylabel('Imaginary Axis');
%% 

z = [];
p = [0, 4, -8, -10];
k = 1;

sys = zpk(z, p, k);


figure;
rlocus(sys);
grid on;
sgrid; 

title('Root Locus of G(s)H(s) = 1 / [s(s-4)(s+8)(s+10)]');
%% 
% Define the transfer function: G(s) = [(s+2)(s+3)] / [s(s+10)(s+8)]
zeros = [-2, -3];
poles = [0, -10, -8];
gain = 1;

sys = zpk(zeros, poles, gain);

% Generate the Bode Plot
figure;
bode(sys);
grid on;

% Add title for clarity
title('Bode Plot of G(s) = (s+2)(s+3) / [s(s+10)(s+8)]');
