function [ objective, gradients ] = network_target_func(X_TRAIN, CSWB )

N_TRAIN = size(X_TRAIN,2);

W1 = reshape(CSWB(1:8), 2, 4);
W2 = reshape(CSWB(9:20), 4, 3);
W3 = reshape(CSWB(21:23), 3, 1);
b1 = reshape(CSWB(24:27),4,1);
b2 = reshape(CSWB(28:30),3,1);
b3 = CSWB(31);

phi = @tanh;
phi1 = @(t) phi(W1'*t + b1);
phi2 = @(t) phi(W2'*phi1(t) + b2);
grad_phi = @(t) sech(t).^2;
grad_phi1 = @(t) diag(grad_phi(W1'*t + b1));
grad_phi2 = @(t) diag(grad_phi(W2'*phi1(t) + b2));

%% analytic calculations
YY = @(X) X(1,:) .* exp(-X(1,:).^2 - X(2,:).^2);
r = @(x) W3'*phi2(x)+b3 - YY(x);
Psi = mean(r(X_TRAIN).^2);
objective = Psi;
if nargout>1
    grad_b3_ = @(t) 2*r(t)* 1;
    grad_W3_ = @(t) 2*r(t)* phi2(t);
    grad_b2_ = @(t) 2*r(t)* (W3'*grad_phi2(t))';
    grad_W2_ = @(t) 2*r(t)* phi1(t) * W3'*grad_phi2(t);
    grad_b1_ = @(t) 2*r(t)* (W3'*grad_phi2(t)*W2'*grad_phi1(t))';
    grad_W1_ = @(t) 2*r(t)* t*W3'*grad_phi2(t)*W2'*grad_phi1(t);
%     grad_b3_ = @(t) 1;
%     grad_W3_ = @(t) phi2(t);
%     grad_b2_ = @(t) (W3'*grad_phi2(t))';
%     grad_W2_ = @(t) phi1(t)*W3'*grad_phi2(t);
%     grad_b1_ = @(t) (W3'*grad_phi2(t)*W2'*grad_phi1(t))';
%     grad_W1_ = @(t) t*W3'*grad_phi2(t)*W2'*grad_phi1(t);
%     
    grad_W1 = @(t) reshape(mean(func_every_column(grad_W1_, t),3),[],1);
    grad_W2 = @(t) reshape(mean(func_every_column(grad_W2_, t),3),[],1);
    grad_W3 = @(t) reshape(mean(func_every_column(grad_W3_, t),3),[],1);
    grad_b1 = @(t) reshape(mean(func_every_column(grad_b1_, t),3),[],1);
    grad_b2 = @(t) reshape(mean(func_every_column(grad_b2_, t),3),[],1);
    grad_b3 = @(t) reshape(mean(func_every_column(grad_b3_, t),3),[],1);

    gradients = [
                grad_W1(X_TRAIN);...
                grad_W2(X_TRAIN);...
                grad_W3(X_TRAIN);...
                grad_b1(X_TRAIN);...
                grad_b2(X_TRAIN);...
                grad_b3(X_TRAIN)
            ];
end
end

function genericApplyToCols = func_every_column(func, matrix)
applyToGivenCol = @(func, matrix) @(col) func(matrix(:, col));
newApplyToCols = @(func, matrix) arrayfun(applyToGivenCol(func, matrix), 1:size(matrix,2), 'UniformOutput', false)';
takeAll = @(x) reshape([x{:}], size(x{1},2), size(x{1},1), []);
genericApplyToCols = takeAll(newApplyToCols(func, matrix));
end
