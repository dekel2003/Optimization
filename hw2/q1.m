
alpha0 = 1;
beta = 0.5;
sigma = 0.25;
epsilon = 10e-5;

%%  Performing Gradient Descent on Rosenbrock function

N=3;
f_1 = @(x) sum((1-x(1:end-1)).^2 +100*(x(2:end)-x(1:end-1).^2).^2);
grad_f1 = @(x) [(-2*(1-x(1:end-1)) -400*x(1:end-1).*(x(2:end)-x(1:end-1).^2)) ;0] +200*([0;(x(2:end)-x(1:end-1).^2)]);
x0 = zeros(N,1);
gradient_descent( f_1, grad_f1, x0, alpha0, beta, sigma, epsilon )