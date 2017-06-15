function gnum = numdiff(f,x)

EPSILON = 1e-6;
E_plus =  repmat(x',length(x),1) + eye(length(x)) * EPSILON;
E_minus = repmat(x',length(x),1) - eye(length(x)) * EPSILON;
gnum = zeros(length(x),1);
% f = @(t) my_func(t,par);

for k = 1:length(x)
    gnum(k) = f(E_plus(k,:)') - f(E_minus(k,:)');
end
gnum = gnum ./ (2 * EPSILON);

end

