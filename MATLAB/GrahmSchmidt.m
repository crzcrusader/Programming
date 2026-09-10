% =========================================================================
% Part b
% =========================================================================

% Define the noisy rotation matrix
R_noisy = [ 0.632, -0.364,  0.722;
            0.485,  0.891, -0.010;
           -0.602,  0.369,  0.687];

% Extract original columns
c1 = R_noisy(:, 1);
c2 = R_noisy(:, 2);
c3 = R_noisy(:, 3);

% Gram-Schmidt Process
v1 = c1;
u1 = v1 / norm(v1);

v2 = c2 - (c2' * u1) * u1;
u2 = v2 / norm(v2);

% Use cross product to ensure orthonormality and right-handedness det(R) = +1
u3_corrected = cross(u1, u2); 

% Assemble the cleaned matrix
R_clean = [u1, u2, u3_corrected];

% Verify R_clean in SO(3)
disp('--- Cleaned Rotation Matrix R_clean ---');
disp(R_clean);
fprintf('Determinant det(R_clean) = %.6f\n', det(R_clean));
disp('R_clean'' * R_clean:');
disp(R_clean' * R_clean);

% =========================================================================
% Part c
% =========================================================================

% Frame translation and target relative coordinates
o0_1 = [0.8; -0.6; 1.2];   % Camera origin relative to Frame {0}
p1   = [0.5; -0.2; 1.5];   % Target position relative to Frame {1}

% Compute absolute position in Frame {0}
p0 = R_clean * p1 + o0_1;

% Display the result
disp('--- Target Position p0 in Base Frame {0} (meters) ---');
disp(p0);

% =========================================================================
% Part d
% =========================================================================

% Define gravity vector in robot base Frame {0}
g0 = [0; 0; -9.81]; % m/s^2

% Compute gravity vector in camera local Frame {1} using R_clean' (transpose)
g1 = R_clean' * g0;

% Display the result
disp('--- Gravity Vector g1 as Observed in Camera Frame {1} (m/s^2) ---');
disp(g1); 

% =========================================================================
% Part e
% =========================================================================

% Define rotation angles in radians
theta_z = deg2rad(-30);
theta_y = deg2rad(60);

% Elementary rotation matrix about current z-axis (Step 1)
R_z = [ cos(theta_z), -sin(theta_z), 0;
        sin(theta_z),  cos(theta_z), 0;
             0       ,       0      , 1];

% Elementary rotation matrix about current y-axis (Step 2)
R_y = [ cos(theta_y), 0, sin(theta_y);
             0      , 1,      0      ;
       -sin(theta_y), 0, cos(theta_y)];

% Composite rotation matrix using post-multiplication rule
R0_final = R_clean * R_z * R_y;

% Target position in base frame {0} (assuming stationary origin o0_1)
p0_final = R0_final * p1 + o0_1;

% New gravity vector observed in camera frame {1}
g1_final = R0_final' * g0;

% =========================================================================
% Display Final Outputs
% =========================================================================
disp('--- Composite Rotation Matrix R0_final ---');
disp(R0_final);

disp('--- New Target Position p0_final in Base Frame {0} (meters) ---');
disp(p0_final);

disp('--- New Gravity Vector g1_final in Camera Frame {1} (m/s^2) ---');
disp(g1_final);

% =========================================================================
% Part 5: Axis-Angle Extraction from R_clean
% =========================================================================

% Call the user-defined axis-angle function on R_clean
[k, theta_deg] = extract_axis_angle(R_clean);

% Display the extracted axis and angle
disp('--- Axis-Angle Representation of R_clean ---');
fprintf('Rotation Angle theta = %.4f degrees\n', theta_deg);
disp('Unit Rotation Axis k =');
disp(k);

% =========================================================================
% Part 6: Eigenvalues and Eigenvectors Verification
% =========================================================================

% 1. Compute Eigenvalues (D) and Eigenvectors (V)
[V, D] = eig(R_clean);

% Extract eigenvalues from the diagonal matrix D
eigenvalues = diag(D);

% Find the index of the real eigenvalue equal to +1.0
[~, idx] = min(abs(eigenvalues - 1.0));

% Extract the corresponding eigenvector
v_lambda1 = V(:, idx);

% Ensure the eigenvector is real and normalized as a unit vector
v_lambda1 = real(v_lambda1);
v_lambda1 = v_lambda1 / norm(v_lambda1);

% Ensure sign alignment for direct comparison with k
if dot(v_lambda1, k) < 0
    v_lambda1 = -v_lambda1;
end

% Display Results
disp('--- Eigenvalues of R_clean ---');
disp(eigenvalues);

disp('--- Eigenvector corresponding to lambda = +1.0 ---');
disp(v_lambda1);

disp('--- Unit Axis k calculated from Part B(a) ---');
disp(k);

% Verify equality
difference = norm(v_lambda1 - k);
fprintf('Difference norm ||v_lambda1 - k|| = %.6e\n', difference);





function [k, theta] = extract_axis_angle(R)
    % EXTRACT_AXIS_ANGLE Extracts axis k and angle theta (in degrees) from R in SO(3).
    %
    % Inputs:
    %   R     - 3x3 Rotation matrix in SO(3)
    % Outputs:
    %   k     - 3x1 Unit vector axis of rotation [kx; ky; kz]
    %   theta - Rotation angle in degrees
    
    % Compute matrix trace
    tr_R = trace(R);
    
    % Compute angle theta in radians using trace formula
    % Clamping argument to [-1, 1] prevents complex values from tiny numerical errors
    cos_theta = (tr_R - 1) / 2;
    cos_theta = max(-1, min(1, cos_theta)); 
    theta_rad = acos(cos_theta);
    
    % Check for non-singular conditions (theta != 0 and theta != pi)
    if sin(theta_rad) == 0
        if theta_rad == 0
            k = [0; 0; 0]; % Identity rotation: axis is undefined/arbitrary
        else
            error('Singular condition theta = pi. Axis extraction requires skew-symmetric decomposition.');
        end
    else
        % Extract axis vector k
        k = (1 / (2 * sin(theta_rad))) * [R(3,2) - R(2,3);
                                         R(1,3) - R(3,1);
                                         R(2,1) - R(1,2)];
                                     
        % Ensure k is a unit vector
        k = k / norm(k);
    end
    
    % Convert angle to degrees
    theta = rad2deg(theta_rad);
end

%% % =========================================================================
% Problem 5: Pre- and Post-Multiplication of Homogeneous Transformations
% =========================================================================
clear; clc; format shortG;

% --- Task A: H0_1 (World to Robot Base Frame) ---
deg2rad = pi/180;
theta1 = 45 * deg2rad;
d0_1 = [2; 3; 0];

R0_1 = [cos(theta1), -sin(theta1), 0;
        sin(theta1),  cos(theta1), 0;
                  0,            0, 1];

H0_1 = [R0_1, d0_1; 
        0, 0, 0, 1];

% --- Task B: H0_2 (Scenario A - Body-Fixed Rotation / Post-Multiplication) ---
theta2 = 90 * deg2rad;
d_local = [0.5; 0; 0.2];

R1_2 = [ cos(theta2), 0, sin(theta2);
                   0, 1,           0;
        -sin(theta2), 0, cos(theta2)];

H1_2 = [R1_2, d_local;
        0, 0, 0, 1];

% Post-multiplication for body-fixed sequence
H0_2 = H0_1 * H1_2;

% --- Task C: H0_3 (Scenario B - Fixed-Frame / Pre-Multiplication) ---
theta3 = 90 * deg2rad;
d_world = [0; 0; 1.5];

% Rotation operator about fixed world X-axis
H_Rx = [1,           0,            0, 0;
        0, cos(theta3), -sin(theta3), 0;
        0, sin(theta3),  cos(theta3), 0;
        0,           0,            0, 1];

% Translation operator along fixed world axes
H_T = [1, 0, 0, d_world(1);
       0, 1, 0, d_world(2);
       0, 0, 1, d_world(3);
       0, 0, 0,          1];

% Pre-multiplication for space-fixed sequence
H0_3 = H_T * H_Rx;

% --- Display Results ---
disp('===================================================');
disp('H0_1 (Robot Base Transform):');
disp(H0_1);

disp('===================================================');
disp('H1_2 (Relative Frame {2} to Frame {1}):');
disp(H1_2);
disp('H0_2 (Absolute Frame {2} via Post-Multiplication):');
disp(H0_2);

disp('===================================================');
disp('H0_3 (Stationary Sensor via Pre-Multiplication):');
disp(H0_3);
