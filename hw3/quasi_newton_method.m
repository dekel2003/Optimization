function [ min_x, m ] = quasi_newton_method( f, grad_f, B0, x0, alpha0, beta, sigma, epsilon )

x = x0;
alpha = alpha0;
iteration = 0;
B = B0;
grad_f_x_next = grad_f(x);
while (norm(grad_f_x_next) >= epsilon)
    iteration = iteration+1;
    grad_f_x = grad_f_x_next;
    direction = get_newton_direction(B, grad_f_x);
    alpha = armijo(f, direction, x, alpha, beta, sigma);
    x_next = x + alpha * direction;
    grad_f_x_next = grad_f(x_next);
    direction = normc(direction);
    if direction' *  grad_f_x_next > direction' *  grad_f_x * 0.9
        B = update_approx_inverse_hessian(B, x_next - x, grad_f_x_next - grad_f_x);
    end
    x = x_next;
    disp(norm(grad_f_x_next));
%     disp([grad_f(x) x]);
    values(iteration) = f(x);
end

min_x = x;

if (nargout>1)
    m = values;
end

end


function dir = get_newton_direction(H_inv, grad_f_x)
    dir = - H_inv * grad_f_x;
end

function alpha_new = armijo(f, direction, x, alpha, beta, sigma)
    m = sum(direction .* normc(direction));
    t = -sigma * m;
    alpha_new = alpha;
    while (f(x) - f(x + alpha_new*direction)) < alpha_new*t
        alpha_new = alpha_new * beta;
    end
end

function B = update_approx_inverse_hessian(B, p, q)
s = B*q;
tau = s'*q;
meu = p'*q;

B = B + (1/meu) * (p*p') - (1/tau)*(s*s');

end