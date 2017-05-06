

x = [ 1 2 3]';
par.phi = @phi;
par.h = @h;
par.EPSILON = eps^(1/3) * max(abs(x));
par.A = magic(3);

%% part 1 - gradients
[~,g1] = f1(x, par);
g2     = numdiff(@f1, x, par);
plot(abs(g1-g2),'*r');

[~,g1] = f2(x, par);
g2     = numdiff(@f2, x, par);
plot(abs(g1-g2),'*r');

%% part 2 - Hessians
[~,~,h1] = f1(x, par);
[~,h2]   = numdiff(@f1, x, par);
imagesc(abs(h1-h2));

[~,~,h1] = f2(x, par);
[~,h2] = numdiff(@f2, x, par);
imagesc(abs(h1-h2));

%% optimize over epsilon - gradient f1

k = 1;
results = zeros(1,1000);
for EPSI = logspace(-15,-4,1000)
    par.EPSILON = EPSI;
    [~,g1] = f1(x, par);
    g2     = numdiff(@f1, x, par);
    results(k) = max(abs(g1-g2));
    k = k+1;
end
loglog(logspace(-15,-4,1000),results);

%% optimize over epsilon - gradient f2
k = 1;
results = zeros(1,1000);
for EPSI = logspace(-15,-4,1000)
    par.EPSILON = EPSI;
    [~,g1] = f2(x, par);
    g2     = numdiff(@f2, x, par);
    results(k) = max(abs(g1-g2));
    k = k+1;
end
loglog(logspace(-15,-4,1000),results);

%% optimize over epsilon - hessian f1

k = 1;
results = zeros(1,1000);
for EPSI = logspace(-15,-4,1000)
    par.EPSILON = EPSI;
    [~,~,h1] = f1(x, par);
    [~,h2]   = numdiff(@f1, x, par);
    results(k) = max(abs(h1(:)-h2(:)));
    k = k+1;
end
loglog(logspace(-15,-4,1000),results);

%% optimize over epsilon - hessian f2

k = 1;
results = zeros(1,1000);
for EPSI = logspace(-15,-4,1000)
    par.EPSILON = EPSI;
    [~,~,h1] = f2(x, par);
    [~,h2]   = numdiff(@f2, x, par);
    results(k) = max(abs(h1(:)-h2(:)));
    k = k+1;
end
loglog(logspace(-15,-4,1000),results);
