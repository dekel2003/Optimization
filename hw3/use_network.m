function [ result ] = use_network( X_TEST, CSWB )


W1 = reshape(CSWB(1:8), 2, 4);
W2 = reshape(CSWB(9:20), 4, 3);
W3 = reshape(CSWB(21:23), 3, 1);
b1 = reshape(CSWB(24:27),4,1);
b2 = reshape(CSWB(28:30),3,1);
b3 = CSWB(31);
% Y = @(X) X(1,:) .* exp(-X(1,:).^2 - X(2,:).^2);

phi = @tanh;
phi1 = @(t) phi(W1'*t + b1);
phi2 = @(t) phi(W2'*phi1(t) + b2);
Y = @(X) W3'*phi2(X) + b3;
result = Y(X_TEST)';
end

