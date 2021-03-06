
%% define function and constraints
Q = [4 0;0 2];
d = [20 2]';
e = 51;
f = @(x,y) 0.5*[x y]*Q*[x y]' -  d'*[x y]' + e;

A = [0.5 1; 1 -1;-1 -1];
b = [1 0 0]';
g = @(i) @(x,y) A(i,:)*[x y]' - b(i);
figure, hold on;
for i=1:3
    fp = fimplicit(g(i));
    fp.Color = 'r';
    fp.LineStyle = '--';
    fp.LineWidth = i;
end
fcontour(f);
legend('constraint 1','constraint 2','constraint 3','f contours');
hold off

%% optimal solution by analytic calculation
x_opt = [2/3 2/3]';

%% analytic calculation of lambda using KKT
lambda_opt = [12 11+1/3 0]';

%% preprocess augmented lagrangian
x0 = [0 0]';
f = @(x) 0.5*x'*Q*x -  d'*x + e;
grad_f = @(x) Q*x - d;
H_f = @(x) Q;
g = @(x) A*x - b;
grad_g = @(x) A;

%% run augmented lagrangian
x_star = augmented_lagrangian( x0, f, grad_f, H_f, g, grad_g );
