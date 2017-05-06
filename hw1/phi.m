function [f,g,H] = phi(x)

f = sin(x(1)*x(2)*x(3));

if (nargout > 1)
    g = cos(x(1)*x(2)*x(3)) * [x(2)*x(3),x(1)*x(3),x(1)*x(2)]';
end

if (nargout > 2)
    H = -f * [x(2)*x(3),x(1)*x(3),x(1)*x(2)]' * [x(2)*x(3),x(1)*x(3),x(1)*x(2)];
    H = H + cos(x(1)*x(2)*x(3)) * ...
        [  0    x(3) x(2) ;
           x(3) 0    x(1) ;
           x(2) x(1) 0   ];
end

end

