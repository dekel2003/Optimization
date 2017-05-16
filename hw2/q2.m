
alpha0 = 1;
beta = 0.5;
sigma = 0.25;
epsilon = 10e-5;

%%  Performing Gradient Descent on Rosenbrock function

N=10;
f_1 = @(x) sum((1-x(1:end-1)).^2 +100*(x(2:end)-x(1:end-1).^2).^2);
grad_f1 = @(x) [(-2*(1-x(1:end-1)) -400*x(1:end-1).*(x(2:end)-x(1:end-1).^2)) ;0] +200*([0;(x(2:end)-x(1:end-1).^2)]);
H_f1 = @(x) zeros(N) + ...
    diag( [2-400*(x(2:end)-x(1:end-1).^2)+800*x(1:end-1).^2;0] + [0;200*ones(N-1,1)] ) + ...
    diag( [-400*x(1:end-1)], 1) + ...
    diag( [-400*x(1:end-1)],-1)      ;
x0 = zeros(N,1);
optimal_val = ones(N,1);
newton_method( f_1, grad_f1, H_f1, x0, alpha0, beta, sigma, epsilon, optimal_val )

%% check numerically
x0 = ((N:-1:1).^1/2)';
par.EPSILON = eps^(1/3) * max(abs(x0));
[gnum,Hnum] = numdiff(f_1,grad_f1,x0,par);
figure,
plot(abs(gnum-grad_f1(x0)),'*r');
figure,
imagesc(abs(Hnum-H_f1(x0)));

%% well conditioned function
alpha0 = pi/10;
N=10;
A = eye(N); A(1,1) = A(1,1)*2;
b = ones(N,1)*-4;
c = 4*N;
f2 = @(x) x'*A*x + b'*x + c;
g2 = @(x) 2*A*x + b;
H2 = @(x) 2*A;
x0 = (1:N)';
optimal_val = ones(N,1)*2; optimal_val(1)=1;
newton_method( f2, g2, H2, x0, alpha0, beta, sigma, epsilon, optimal_val )

%% check numerically

par.EPSILON = eps^(1/3) * max(abs(x0));
[gnum,Hnum] = numdiff(f2,g2,x0,par);
figure,
plot(abs(gnum-g2(x0)),'*r');
figure,
imagesc(abs(Hnum-H2(x0)));

%% ill conditioned function
alpha0 = pi/10;
N=10;
A = eye(N); A(1,1) = 1e2; A(2,2) = 1e-2;
b = ones(N,1)*-4;
c = 4*N;
f3 = @(x) x'*A*x + b'*x + c;
g3 = @(x) 2*A*x + b;
H3 = @(x) 2*A;
x0 = (1:N)';
optimal_val = ones(N,1)*2; optimal_val(1)=0.02; optimal_val(2)=200;
newton_method( f3, g3, H3, x0, alpha0, beta, sigma, epsilon, optimal_val )

%% check numerically

par.EPSILON = eps^(1/3) * max(abs(x0));
[gnum,Hnum] = numdiff(f3,g3,x0,par);
figure,
plot(abs(gnum-g3(x0)),'*r');
figure,
imagesc(abs(Hnum-H3(x0)));