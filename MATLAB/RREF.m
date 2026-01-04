% File: classify_solution_conditions.m
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

% Row reduce
R = rref(Ab);

% Extract last row
lastRow = R(3, :);
lhs = lastRow(1:3);
rhs = lastRow(4);

% Set conditions
inf_cond = simplify(lhs == 0 & rhs == 0);    % [0 0 0 | 0]
no_cond  = simplify(lhs == 0 & rhs ~= 0);    % [0 0 0 | c] where c ≠ 0
unique_cond = simplify(~(inf_cond | no_cond));  % all other cases

fprintf('-----------------------------\n');
fprintf('♾ Infinitely Many Solutions:\n');
if isAlways(inf_cond)
    fprintf('k and h can be any values\n');
elseif any(inf_cond)
    sol_inf = solve([lhs == 0, rhs == 0], [h, k], 'Real', true);
    disp(sol_inf)
else
    fprintf('No values of h and k result in infinite solutions.\n');
end

fprintf('-----------------------------\n');
fprintf('❌ No Solution:\n');
if isAlways(no_cond)
    fprintf('k and h must satisfy:\n');
    pretty(no_cond)
elseif any(no_cond)
    fprintf('k and h must satisfy:\n');
    pretty(no_cond)
else
    fprintf('No values of h and k result in no solution.\n');
end

fprintf('-----------------------------\n');
fprintf('✅ Unique Solution:\n');
if isAlways(unique_cond)
    fprintf('k and h can be any values (except special cases above)\n');
else
    fprintf('k and h must satisfy:\n');
    pretty(unique_cond)
end
