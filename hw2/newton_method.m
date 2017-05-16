function [ min_x, min_val ] = newton_method( f, grad_f, H_f, x0, alpha0, beta, sigma, epsilon, optimal_val )

x = x0;
alpha = alpha0;
iteration = 0;
while (norm(grad_f(x)) >= epsilon)
    iteration = iteration+1;
    direction = get_newton_direction(H_f, grad_f, x);
    alpha = armijo(f, direction, x, alpha, beta, sigma);
    x = x + alpha * direction;
%     disp(norm(f(x)));
%     disp([grad_f(x) x]);
    values(iteration) = f(x) - f(optimal_val);
end

semilogy(values)
title('newton method');
xlabel('iteration') % x-axis label
ylabel('f(x)-p*') % y-axis label

min_x = x;

if (nargout>1)
    min_val = f(x);
end

end


function dir = get_newton_direction(H_f, grad_f, x)
[L,d,e,pneg]=mcholmz(H_f(x));
g1 = - grad_f(x);
g2 = L \ g1;
g3 = diag(d) \ g2;
dir = L'\ g3;

end

function alpha_new = armijo(f, grad_f_x, x, alpha, beta, sigma)
    m = sum(grad_f_x .* normc(grad_f_x));
    t = -sigma * m;
    alpha_new = alpha;
    while (f(x) - f(x + alpha_new*grad_f_x)) < alpha_new*t
        alpha_new = alpha_new * beta;
    end
end