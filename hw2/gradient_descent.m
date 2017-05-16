function [ min_x, min_val ] = gradient_descent( f, grad_f, x0, alpha0, beta, sigma, epsilon, optimal_val )
    

x = x0;
alpha = alpha0;
iteration = 0;
while (sqrt(sum(grad_f(x).^2)) >= epsilon)
    iteration = iteration+1;
    alpha = armijo(f, -(grad_f(x)), x, alpha, beta, sigma);
    x = x - alpha * (grad_f(x));
    disp(norm(grad_f(x)));
    disp([grad_f(x) x]);
    values(iteration) = f(x) - f(optimal_val);
end

semilogy(values)
title('gradient descent');
xlabel('iteration') % x-axis label
ylabel('f(x)-p*') % y-axis label

min_x = x;

if (nargout>1)
    min_val = f(x);
end

end


function alpha_new = armijo(f, grad_f_x, x, alpha, beta, sigma)
    m = -grad_f_x' * normc(grad_f_x);
    t = -sigma * m;
    alpha_new = alpha;
    while (f(x + alpha_new*grad_f_x) - f(x)) > alpha_new*t
        alpha_new = alpha_new * beta;
    end
end