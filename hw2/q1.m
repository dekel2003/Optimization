

beta = 0.5;
sigma = 0.25;
epsilon = 10e-5;

%%  Performing Gradient Descent on Rosenbrock function
alpha0 = 1;

N=10;
f_1 = @(x) sum((1-x(1:end-1)).^2 +100*(x(2:end)-x(1:end-1).^2).^2);
grad_f1 = @(x) [(-2*(1-x(1:end-1)) -400*x(1:end-1).*(x(2:end)-x(1:end-1).^2)) ;0] +200*([0;(x(2:end)-x(1:end-1).^2)]);
x0 = zeros(N,1);
optimal_val = ones(N,1);
gradient_descent( f_1, grad_f1, x0, alpha0, beta, sigma, epsilon, optimal_val )

%% well conditioned function
alpha0 = pi/10;
N=10;
A = eye(N); A(1,1) = A(1,1)*2;
b = ones(N,1)*-4;
c = 4*N;
f2 = @(x) x'*A*x + b'*x + c;
g2 = @(x) 2*A*x + b;
x0 = (1:N)';
optimal_val = ones(N,1)*2; optimal_val(1)=1;
gradient_descent( f2, g2, x0, alpha0, beta, sigma, epsilon, optimal_val )

%% ill conditioned function
alpha0 = pi/10;
N=10;
A = eye(N); A(1,1) = 1e2; A(2,2) = 1e-2;
b = ones(N,1)*-4;
c = 4*N;
f3 = @(x) x'*A*x + b'*x + c;
g3 = @(x) 2*A*x + b;
x0 = (1:N)';
optimal_val = ones(N,1)*2; optimal_val(1)=0.02; optimal_val(2)=200;
gradient_descent( f3, g3, x0, alpha0, beta, sigma, epsilon, optimal_val )


