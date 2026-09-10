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

