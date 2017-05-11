function gnum = numdiff2(my_func,x,par)

[r,c] = size(x);
x=x(:);
EPSILON = par.EPSILON;
E_plus =  repmat(x',length(x),1) + eye(length(x)) * EPSILON;
E_minus = repmat(x',length(x),1) - eye(length(x)) * EPSILON;
gnum = zeros(length(x),1);
f = @(t) my_func(t,par);

for k = 1:length(x)
    gnum(k) = f(reshape(E_plus(k,:)',r,c)) - f(reshape(E_minus(k,:)',r,c));
end
gnum = gnum ./ (2 * EPSILON);
gnum = reshape(gnum,r,c);
end

