%% J. Marley
%% Lesson 23 Defining Circuit Elements

s = tf('s');

R1 = 7.8;
R2 = 41;
C = 8.13e-3;
L = 3;

%% Simulate Uncompensated System:
G = R2/(L*C*R2*s^2+(C*R1*R2+L)*s+R1+R2);
stepinfo(feedback(G,1))

%% Note: To simulate the compensated system, 
%% enter the function G*Gc from your Simulink
%% Control System Designer and then uncomment 
%% the following three lines of code:

GGc = ((1+0.22*s)*(1+0.22))/(1+0.55*s)*(1+0.64*s+(0.5*s)^2)
stepinfo(feedback(GGc,1))
step(feedback(GGc,1))