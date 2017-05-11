
W1 = ones(2,4) * 0.1;
W2 = ones(4,3) * 0.2;
W3 = ones(3,1) * 0.3;
b1 = [1 1 1 1]';
b2 = [1 1 1]';
b3 = 1;
x = [1 2]';
y = exp(-(sum(x.^2)));
phi = @tanh;
phi1 = @(t) phi(W1'*t + b1);
phi2 = @(t) phi(W2'*phi1(t) + b2);
grad_phi = @(t) ones(length(t),1) - (tanh(t)).^2;
grad_phi1 = @(t) diag(phi(W1'*t + b1));
grad_phi2 = @(t) diag(phi(W2'*phi1(t) + b2));
%% analytic calculations
r = W3'*phi2(x)+b3 - y; 

grad_b3 = @(t) 2*r* 1;
grad_W3 = @(t) 2*r* phi2(t);

grad_b2 = @(t) 2*r* (W3'*grad_phi2(t))';
grad_W2 = @(t) 2*r* phi1(t) * W3'*grad_phi2(t);

grad_b1 = @(t) 2*r* (W3'*grad_phi2(t)*W2'*grad_phi1(t))';
grad_W1 = @(t) 2*r* t*W3'*grad_phi2(t)*W2'*grad_phi1(t);

%%
par.EPSILON = 10^-8;


F1 = @(W1,par) 2*r* W3'*phi(W2'*phi(W1'*x+b1)+b2)+b3;
F2 = @(W2,par) 2*r* W3'*phi(W2'*phi(W1'*x+b1)+b2)+b3;
F3 = @(W3,par) 2*r* W3'*phi(W2'*phi(W1'*x+b1)+b2)+b3;
F4 = @(b1,par) 2*r* W3'*phi(W2'*phi(W1'*x+b1)+b2)+b3;
F5 = @(b2,par) 2*r* W3'*phi(W2'*phi(W1'*x+b1)+b2)+b3;
F6 = @(b3,par) 2*r* W3'*phi(W2'*phi(W1'*x+b1)+b2)+b3;

figure;

subplot(2,3,1);
g1 = grad_W1(x);
g2     = numdiff2(F1, W1, par);
imagesc(abs(g1-g2));
colorbar;
title('W1');

subplot(2,3,2);
g1 = grad_W2(x);
g2     = numdiff2(F2, W2, par);
imagesc(abs(g1-g2));
colorbar;
title('W2');

subplot(2,3,3);
g1 = grad_W3(x);
g2     = numdiff2(F3, W3, par);
imagesc(abs(g1-g2));
colorbar;
title('W3');

subplot(2,3,4);
g1 = grad_b1(x);
g2     = numdiff2(F4, b1, par);
plot(abs(g1-g2),'*r');
title('b1');

subplot(2,3,5);
g1 = grad_b2(x);
g2     = numdiff2(F5, b2, par);
plot(abs(g1-g2),'*r');
title('b2');

subplot(2,3,6);
g1 = grad_b3(x);
g2     = numdiff2(F6, b3, par);
plot(abs(g1-g2),'*r');
title('b3');




