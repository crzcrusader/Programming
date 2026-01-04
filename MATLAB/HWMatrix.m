% File: find_unique_solutions_explicit.m
clc;
clear;

% Define symbolic variables
syms h k real

% Define matrix A and vector b
A = [ -7  4   7;
      -8 -7  -8;
       5 -26  h ];

b = [ -7;
       3;
       k ];

% Augmented matrix
Ab = [A b];

% Reduced row echelon form
R = rref(Ab);

% Extract last row
lastRow = R(3, :);
lhs = lastRow(1:3);  % Coefficients
rhs = lastRow(4);    % Constant

% Analyze:
% Infinite solutions: [0 0 0 | 0]
% No solution:        [0 0 0 | nonzero]
% Unique solution:    anything else

% Case 1: Infinite solutions
eqs_inf = [lhs == 0, rhs == 0];
sol_inf = solve(eqs_inf, [h, k], 'Real', true);

% Case 2: No solution
eqs_none = [lhs == 0, rhs ~= 0];
% We use assumptions instead of solve for not-equal
cond_no_sol = lhs(1)==0 & lhs(2)==0 & lhs(3)==0 & rhs ~= 0;

% Case 3: Unique solution — not Case 1 or Case 2
% Condition: the last row is NOT all zeros
cond_unique = simplify(~(lhs(1)==0 & lhs(2)==0 & lhs(3)==0));

disp('--------------------------------------------')
disp('🔁 Infinite Solutions:')
if isempty(sol_inf)
    disp('There are NO values of h and k that give infinitely many solutions.')
else
    disp(sol_inf)
end

disp('--------------------------------------------')
disp('❌ No Solution:')
disp('Occurs when:')
pretty(cond_no_sol)

disp('--------------------------------------------')
disp('✅ Unique Solution:')
disp('Occurs when:')
pretty(cond_unique)


A = [1 -2 1;
     -1 1 -1;
     1 3 0];
