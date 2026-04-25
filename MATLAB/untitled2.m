%% RLC Circuit Analysis: Unity Feedback System
clear; clc;

% 1. Define Component Values (Current Values)
R1 = 4.5;      
R2 = 3000;    
L  = 0.8;    
C  = 0.02481;  

% 2. Create the Original (Uncompensated) Plant G(s)
num = [R2 / (L * R2 * C)];
den = [1, ((R1*R2*C + L) / (L*R2*C)), ((R1 + R2) / (L * R2 * C))];
G = tf(num, den);

% 3. Create the Unity Feedback System: T(s) = G(s) / (1 + G(s))
T = feedback(G, 1);

% 4. Extract Performance Metrics using 'stepinfo'
info_cl = stepinfo(T);

% 5. Determine the Final Value (Steady-State Value)
% For a unit step input, the final value is the DC gain of the closed-loop system
final_val = dcgain(T);

% --- Display Results for Answer Sheet ---
fprintf('--- Closed-Loop (Unity Feedback) Metrics ---\n');
fprintf('Peak Time (Tp):         %.4f s\n', info_cl.PeakTime);
fprintf('Settling Time (Ts):     %.4f s\n', info_cl.SettlingTime);
fprintf('Percent Overshoot (%%OS): %.2f %%\n', info_cl.Overshoot);
fprintf('Final Value (v_c_inf):  %.4f\n', final_val);

% 6. Plot Step Response
figure;
step(T);
grid on;
title('Step Response of Unity Feedback System');
ylabel('Voltage V_c (Volts)');
xlabel('Time (seconds)');