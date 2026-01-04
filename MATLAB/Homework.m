% Define complex matrix A
A = [(-0.025 + 1i*0.01), -0.025;
      3,                 (1 - 1i*2)];

% Define vector B
B = [5.7956 + 1i*1.5529;
     0];

% Solve for V = [V1; V2]
V = A \ B;

% Display the result
disp('V1 =');
disp(V(1));

disp('V2 =');
disp(V(2));

