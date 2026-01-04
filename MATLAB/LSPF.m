% Least square polynomial fit
% The fitting polynomial is of degree 3.
% Given data points
t = [1 , 2, 3, 4] ;
f = [ 1 , 3, 10 , 15] ;
m = 3;
P = polyfit (t , f, m)
t1 = - 1 : 0.001 : 5
g = polyval(P , t1)
hold on
plot (t, f, 'b')
plot (t1 , g)
grid on
xlabel ( ' t')
ylabel ( ' f(t), g(t) ')
hold off