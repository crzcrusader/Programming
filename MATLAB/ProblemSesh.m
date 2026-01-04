% rewrite as z^3 +27 and define polynomial coefficients

coeffs = [1 0 0 0 0 0 -1j*45];

%find roots

z = roots(coeffs);

disp('Roots of z^3 + 27 = 0')
disp(z);

figure;
compass(z);
title('Roots of z^3 = -27');