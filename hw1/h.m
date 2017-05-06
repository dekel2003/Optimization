function [f,g,H] = h(x)

f = exp(x);

if (nargout > 1)
    g = f;
end

if (nargout > 2)
    H = f;
end

end

