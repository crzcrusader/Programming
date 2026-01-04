% File: check_and_display_inverse.m
clc;
clear;

% Define a 3x3 matrix A (edit this to test other matrices)
A = [1 2 3;
     8 6 6;
     3 -4 -9];

% Check if the determinant is nonzero
if det(A) ~= 0
    disp('Yes, the inverse exists.')
    invA = inv(A);
    disp('The inverse matrix is:')
    disp(invA)
else
    disp('No, the inverse does not exist.')
end
