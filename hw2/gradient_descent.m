function [ min_x, min_val ] = gradient_descent( f, grad_f, x0, alpha0, beta, sigma, epsilon )
    

x = x0;
alpha = alpha0;
while (norm(grad_f(x)) >= epsilon)
    alpha = armijo(f, -(grad_f(x)), x, alpha, beta, sigma);
    x = x - alpha * (grad_f(x));
    disp(norm(f(x)));
    disp([grad_f(x) x]);
end

min_x = x;

if (nargout>1)
    min_val = f(x);
end

end





function alpha_new = armijo(f, grad_f_x, x, alpha, beta, sigma)
    m = sum(grad_f_x .* normc(grad_f_x));
    t = -sigma * m;
    alpha_new = alpha;
    while (f(x) - f(x + alpha_new*grad_f_x)) < alpha_new*t
        alpha_new = alpha_new * beta;
    end
end