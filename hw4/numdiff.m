function [gnum,Hnum] = numdiff(f,g,x,par)

EPSILON = par.EPSILON;
E_plus =  repmat(x',length(x),1) + eye(length(x)) * EPSILON;
E_minus = repmat(x',length(x),1) - eye(length(x)) * EPSILON;
gnum = zeros(length(x),1);
% f = @(t) my_func(t,par);

for k = 1:length(x)
    gnum(k) = f(E_plus(k,:)') - f(E_minus(k,:)');
end
gnum = gnum ./ (2 * EPSILON);

if (nargout > 1)
    Hnum = zeros(length(x));
%     g = @(t) (my_func(t,par));
    for k = 1:length(x)
        gp = g(E_plus(k,:)');
        gm = g(E_minus(k,:)');
        Hnum(:,k) = gp - gm;
    end
    Hnum = Hnum ./ (2 * EPSILON);
end

end

