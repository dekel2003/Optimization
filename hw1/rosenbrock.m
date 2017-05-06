function [ f, grad_f ] = rosenbrock()

f = @(x) sum((1-x(1:end-1)).^2 +100*(x(2:end)-x(1:end-1).^2).^2);
grad_f = @(x) [(-2*(1-x(1:end-1)) -400*x(1:end-1).*(x(2:end)-x(1:end-1).^2)) ;0] +200*([0;(x(2:end)+ -x(1:end-1).^2)]);

end

