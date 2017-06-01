
alpha0 = 1;
beta = 0.5;
sigma = 0.25;
epsilon = 1e-5;

%%  Performing Quasi-Newton method on Rosenbrock function

N=10;
f = @(x) sum((1-x(1:end-1)).^2 +100*(x(2:end)-x(1:end-1).^2).^2);
grad_f = @(x) [(-2*(1-x(1:end-1)) -400*x(1:end-1).*(x(2:end)-x(1:end-1).^2)) ;0] +200*([0;(x(2:end)-x(1:end-1).^2)]);
x0 = zeros(N,1);
optimal_val = ones(N,1);
[x,m] = quasi_newton_method( f, grad_f, eye(N), x0, alpha0, beta, sigma, epsilon);

semilogy(m - f(optimal_val));
title('newton method');
xlabel('iteration') % x-axis label
ylabel('f(x)-p*') % y-axis label

%%