%detector de bordes 2d
function h = d2dgauss(n1, sigma1, n2, sigma2, theta)

r = [cos(theta), - sin(theta); sin(theta), cos(theta)];
for i = 1 : n2
    for j = 1 : n1
        u = r * [j - (n1 + 1)/2, i-(n2+1)/2]';
        h(i,j) = gauss(u(1), sigma1) * dgauss(u(2), sigma2);
    end
end

h = h / sqrt(sum(sum(abs(h).*abs(h))));

%gauss
function y = gauss(x, std)
y = exp(-x^2/(2*std^2)) / (std * sqrt(2*pi));

%derivada primera de gauss
function y = dgauss(x,std)
y = -x * gauss(x, std) / std^2;