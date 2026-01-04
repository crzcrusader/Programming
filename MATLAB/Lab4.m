%problem 1 code:
A = [2 0; -1 -1; 0 -2];
B = [1 1; -2 3; -1 1];

DimentionalityA = size(A)
DimentionalityB = size(B)

TransposeA = A.'
TransposeB = B.'

D = A - B

M1 = A .* 3
M2 = 10 .* B

D1 = A./2

P1 = A * A'

firstRow = A(1,:) * B(1,:)'

ones = [1 1 1; 1 1 1];
P2 = A * ones

I_2 = eye(2);
P3 = A * I_2

I_3 = eye(3);
P4 = I_3 * A

X = [1 -2 3];
W = X * X.'
P = X.' * X
N = norm(X)^(2)

%% Script for problem 2

TX = [1 0 5; 0 1 0; 0 0 1];  %define all movement matrix here
RCC = [0 -1 0; 1 0 0; 0 0 1];
TY = [1 0 0; 0 1 -2; 0 0 1];
RCW = [-1 0 0; 0 -1 0; 0 0 1];

%start with the end position and multiply it by the inverse of each
%movement matrix
PT0 = [0 ; -3 ; 1]

PT1 = inv(RCW) * PT0

PT2 = inv(TY) * PT1

PT3 = inv(RCC) * PT2

PT4 = inv(TX) * PT3

D = RCW * TY * RCC * TX

D_INV = inv(D) 

PT5 = D * PT4

%% script for problem 3

% Define square
X = [-0.5 -0.5 0.5  0.5 -0.5];
Y = [-0.5  0.5 0.5 -0.5 -0.5];

% Plot rotated + translated 
figure;

subplot(1,2,1);
rotate_translate(X, Y, pi/4, 0, 0, 'r');
title('Rotated Shape');
xticks(-5:1:5);
xlim([-5 5]);
ylim([-5 5]);

subplot(1,2,2);
rotate_translate(X, Y, 0, 1, 2, 'r');
title('Shifted Shape');
xticks(-5:1:5);
xlim([-5 5]);
ylim([-5 5]);


function rotate_translate(X, Y, angle, xshift, yshift, R)
% rotate_translate rotates and translates a sqaure
%
% INPUTS:
%   X, Y     - Vectors defining the object's original x and y coordinates
%   angle    - Rotation angle in radians (counter-clockwise)
%   xshift   - Shift in x-direction
%   yshift   - Shift in y-direction
%   R        - Color (e.g., 'b', 'r', 'g', or RGB triplet)
%

    shape = [X; Y];
    
    R_matrix = [cos(angle), -sin(angle);
                sin(angle),  cos(angle)];
    
    
    rotated = R_matrix * shape;
    
    
    translated = rotated + [xshift; yshift];
   
    fill(translated(1,:), translated(2,:), R, 'EdgeColor', 'k');
    axis equal;
    grid on;
end

