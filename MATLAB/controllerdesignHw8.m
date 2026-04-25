clc; clear; close all;

s = tf('s');
G = 500*(s+1)/(s*(s+10)*(s+2));

figure;
bode(G);
grid on;
title('Open-Loop Bode Plot');

figure;
margin(G);
grid on;
title('Gain and Phase Margins');
%% question 4
clc; clear; close all;

s = tf('s');
K = 12000;
G = (K*(s+2))/((s+4)*(s+20)*(s+10));

figure;
bode(G);
grid on;
title('Open-Loop Bode Plot');

figure;
margin(G);
grid on;
title('Open-Loop Gain and Phase Margins');
%% estimating damping ratio
clc; clear; close all;

s = tf('s');

K = 12000;   % since Kv = 10
G = (K*(s+2))/((s+4)*(s+20)*(s+10));

figure;
margin(G);
grid on;
title('Open-Loop Bode Plot with Margins');

[GM, PM, Wcg, Wcp] = margin(G);

fprintf('Gain margin = %.4f (%.4f dB)\n', GM, 20*log10(GM));
fprintf('Phase margin = %.4f deg\n', PM);
fprintf('Gain crossover frequency = %.4f rad/s\n', Wcg);
fprintf('Phase crossover frequency = %.4f rad/s\n', Wcp);

% Estimate damping ratio from phase margin
zeta_est = PM / 100;   % quick classroom approximation

fprintf('Estimated damping ratio = %.4f\n', zeta_est);
%% %OS for uncomensated system
clc; clear; close all;

s = tf('s');
K = 1;   % replace with the gain for your uncompensated system

G = K*(s+2)/((s+4)*(s+20)*(s+10));

T = feedback(G,1);   % unity-feedback closed-loop system

figure;
step(T);
grid on;
title('Closed-Loop Step Response');

info = stepinfo(T);

fprintf('Percent Overshoot = %.2f %%\n', info.Overshoot);
fprintf('Peak Time = %.4f s\n', info.PeakTime);
fprintf('Settling Time = %.4f s\n', info.SettlingTime);

