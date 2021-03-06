function [ x_star ] = augmented_lagrangian( x0, f, grad_f, H_f, g, grad_g, H_g )

p_max = 1000.0;
alpha = 2;

p=1;
meu = 0.5 * ones(numel(g(x0)),1);

F =      @(x) f(x) +     (meu'/p) * phi(p*g(x))                   ;
grad_F = @(x) grad_f(x) + grad_g(x)' * (meu .* grad_phi(p*g(x)))  ;
H_F = @(x) H_f(x) + grad_g(x)' * p*meu * H_phi(p*g(x))' * grad_g(x);

x_opt = [2/3 2/3]';
lambda_opt = [12 11+1/3 0]';
x_star = x0;
alpha0 = 1;
beta = 0.5;
sigma = 0.25;
epsilon = 1e-5;
x = newton_method( F, grad_F, H_F, x0, alpha0, beta, sigma, epsilon );
iteration = 1;
% values(iteration) = norm(grad_F(x0));
% values(iteration) = max([g(x0); 0]);
% values(iteration) = abs(f(x0) - f(x_opt));
% values(iteration) = norm(x0 - x_opt);
values(iteration) = norm(meu - lambda_opt);
while abs(f(x) - f(x_star)) > epsilon
    iteration = iteration + 1;
    meu = meu .* grad_phi(p*g(x));
%     values(iteration) = norm(grad_F(x));
%     values(iteration) = max([g(x); 0]);
%     values(iteration) = abs(f(x) - f(x_opt));
%     values(iteration) = norm(x - x_opt);
    values(iteration) = norm(meu - lambda_opt);
%     disp(meu);
    if p < p_max
        p = alpha * p;
        meu = meu / alpha;
    end
    x_star = x;
    F =      @(x) f(x) +     (meu'/p) * phi(p*g(x))                   ;
    grad_F = @(x) grad_f(x) + grad_g(x)' * (meu .* grad_phi(p*g(x)))  ;
    H_F = @(x) H_f(x) + grad_g(x)' * meu * H_phi(g(x))' * grad_g(x);

    x = newton_method( F, grad_F, H_F, x_star, alpha0, beta, sigma, epsilon );
%     disp(x);

end

semilogy(values+eps)
title('Augmented Lagrangian');
xlabel('iteration') % x-axis label
% ylabel('norm of gradient of Agg. func') % y-axis label
% ylabel('max constraint violation') % y-axis label
% ylabel('residual in the objective func') % y-axis label
% ylabel('distance to the optimal point')
ylabel('distance to the optimal multipliers')

    function y = phi(x)
        y = zeros(numel(x),1);
        for i=1:numel(x)
           if x(i) >= -0.5
               y(i) = 0.5*x(i)^2 + x(i);
           else
               y(i) = -0.25 * log(-2 * x(i)) - 0.375;
           end
        end
    end

    function y = grad_phi(x)
        y = zeros(numel(x),1);
        for i=1:numel(x)
           if x(i) >= -0.5
               y(i) = x(i) + 1;
           else
               y(i) = -1 / (4*x(i));
           end
        end
    end

    function y = H_phi(x)
        y = zeros(numel(x),1);
        for i=1:numel(x)
           if x(i) >= -0.5
               y(i) = 1;
           else
               y(i) = -1 / (4*x(i)^2);
           end
        end
    end
end

