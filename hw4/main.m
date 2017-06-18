

%% define function and constraints
f = @(x,y) x.*exp(-x.^2-y.^2)+(x.^2+y.^2)/20;
g = @(x,y) x.*y/2+(x+2).^2+(y-2).^2/2-2;
fimplicit(g)
axis([-6 0 -1 7])
hold on
fcontour(f)
plot(-.9727,.4685,'ro');
legend('constraint','f contours');
hold off

%% define function and constraints
Q = [4 0;0 2];
d = [20 2]';
e = 51;
f = @(x,y) 0.5*[x y]*Q*[x y]' -  d'*[x y]' + e;

A = [0.5 1; 1 -1;-1 -1];
b = [1 0 0]';
g = @(i) @(x,y) A(i,:)*[x y]' - b(i);
figure, hold on;
for i=1:3
    fp = fimplicit(g(i));
    fp.Color = 'r';
    fp.LineStyle = '--';
    fp.LineWidth = i;
end
fcontour(f);
legend('constraint 1','constraint 2','constraint 3','f contours');
hold off

%% optimal solution by analytic calculation
x_opt = [2/3 2/3]';

%% analytic calculation of lambda using KKT
lambda_opt = [16+1/3 17]';


