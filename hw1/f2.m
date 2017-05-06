function [f,g,H] = f2(x,par)

f = par.h(par.phi(x));


if (nargout > 1)
    [u,grad_phi_x] = par.phi(x);
    [~,diff_h_u] = par.h(u);
    g = grad_phi_x * diff_h_u';
end

if (nargout > 2)
    [u,grad_phi_x,H_phi_x] = par.phi(x);
    [~,diff1_h_u,diff2_h_u] = par.h(u);
    H = H_phi_x * diff1_h_u + grad_phi_x * diff2_h_u * grad_phi_x';
end

end

