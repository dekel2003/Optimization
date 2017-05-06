function [f,g,H] = f1(x,par)

f = par.phi(par.A * x);

if (nargout > 1)
    [~,grad_phi_u] = par.phi(par.A * x);
    g = par.A' * grad_phi_u;
end

if (nargout > 2)
    [~,~,H_phi_u] = par.phi(par.A * x);
    H = par.A' * H_phi_u * par.A;
end

end

