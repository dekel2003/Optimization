
%% plot objective function
[X1, X2] = meshgrid(-2:.2:2, -2:.2:2);
Y = X1 .* exp(-X1.^2 - X2.^2);
figure; surf(X1, X2, Y);

%% generate training set and test set
Ntrain=500;
X_train= 4*rand(2,Ntrain)-2;

Ntest=200;
X_test= 4*rand(2,Ntest)-2;

Y_train = X_train(1,:) .* exp(-X_train(1,:).^2 - X_train(2,:).^2);
Y_test = X_test(1,:) .* exp(-X_test(1,:).^2 - X_test(2,:).^2);

%% define network initial params

% W1 = ones(2,4) * 0.1;
W1 = randn(2,4)/sqrt(4);
% W2 = ones(4,3) * 0.2;
W2 = randn(4,3)/sqrt(3);
% W3 = ones(3,1) * 0.3;
W3 = randn(3,1)/sqrt(1);
b1 = [0 0 0 0]';
b2 = [0 0 0]';
b3 = 0;

CSWB = [W1(:);W2(:);W3(:);b1(:);b2(:);b3(:)];
[ objective, gradients ] = network_target_func( X_train, CSWB );
alpha0 = 0.1;
beta = 0.5;
sigma = 0.1;
epsilon = 1e-5;

%% wrap and run
% f = objective;
% grad_f = gradients;
B0 = eye(length(gradients));
x0 = CSWB;
target_func = @(x) network_target_func(X_train, x);
[ min_x, m ] = quasi_newton_method2( target_func, B0, x0, alpha0, beta, sigma, epsilon );

%% plot convergence curve
semilogy(m);
title('quasi-newton method');
xlabel('iteration') % x-axis label
ylabel('Error') % y-axis label

%% fit test
network_reconstruction = use_network( X_test, min_x );

f = fit([X_test(1,:)', X_test(2,:)'], network_reconstruction,'linearinterp');
plot( f, [X_test(1,:)', X_test(2,:)'], network_reconstruction)

%% compare with fminunc

options = optimoptions('fminunc','Algorithm','quasi-newton','SpecifyObjectiveGradient',true);
[x,fval] = fminunc(target_func,x0,options);

%% fminunc fit test
network_reconstruction = use_network( X_test, x );

f = fit([X_test(1,:)', X_test(2,:)'], network_reconstruction,'linearinterp');
plot( f, [X_test(1,:)', X_test(2,:)'], network_reconstruction)





