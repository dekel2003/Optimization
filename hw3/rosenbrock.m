function [ f, grad_f ] = rosenbrock( x )

N=10;
f = sum((1-x(1:end-1)).^2 +100*(x(2:end)-x(1:end-1).^2).^2);
grad_f = [(-2*(1-x(1:end-1)) -400*x(1:end-1).*(x(2:end)-x(1:end-1).^2)) ;0] +200*([0;(x(2:end)-x(1:end-1).^2)]);
% H_f = zeros(N) + ...
%     diag( [2-400*(x(2:end)-x(1:end-1).^2)+800*x(1:end-1).^2;0] + [0;200*ones(N-1,1)] ) + ...
%     diag( [-400*x(1:end-1)], 1) + ...
%     diag( [-400*x(1:end-1)],-1)      ;

end

