% 20180490 Jaehun Lee HW3 Q2
clear, clc

% [x0,x1,...,xn-1]
sample_x = linspace(-1,1,11);
% [y0,y1,...,yn-1]
sample_y = zeros(1,11);
for i=1:11
    sample_y(i) = 1/(1+25*[sample_x(i)]^2);
end

% h_i = 0.2
% w_i = h_i-1 / (h_i-1 + h_i) = 0.5
% r_i = 6/(h_i + h_i-1) * [ (y_i+1 - y_i) / h_i - (y_i - y_i-1) / h_i-1 ]
%     = 75 * (y_i+1 - 2 * y_i + y_i-1)

h = 0.2;

T = [1 0 0 0 0 0 0 0 0 0 0; ...
    0.5 2 0.5 0 0 0 0 0 0 0 0; ...
    0 0.5 2 0.5 0 0 0 0 0 0 0; ...
    0 0 0.5 2 0.5 0 0 0 0 0 0; ...
    0 0 0 0.5 2 0.5 0 0 0 0 0; ...
    0 0 0 0 0.5 2 0.5 0 0 0 0; ...
    0 0 0 0 0 0.5 2 0.5 0 0 0; ...
    0 0 0 0 0 0 0.5 2 0.5 0 0; ...
    0 0 0 0 0 0 0 0.5 2 0.5 0; ...
    0 0 0 0 0 0 0 0 0.5 2 0.5; ...
    0 0 0 0 0 0 0 0 0  0 1]

r = zeros(11,1);
for i=2:10
    r(i) = 75 * [sample_y(i+1) - 2*sample_y(i) + sample_y(i-1)];
end

sigma = T\r

% coefficients for the cubic spline

alpha = zeros(10,1);
for i=1:10
alpha(i) = [sigma(i+1)-sigma(i)]/(6*h);
end

beta = zeros(10,1);
for i=1:10
beta(i) = 0.5*sigma(i);
end

gamma = zeros(10,1);
for i=1:10
gamma(i) = [sample_y(i+1)-sample_y(i)]/h - (h/6)*[sigma(i+1)+2*sigma(i)];
end

delta = zeros(10,1);
for i=1:10
delta(i) = sample_y(i);
end

% diff = S - f
sample_x_2 = linspace(-1,1,51);
sample_y_2 = zeros(1,51);
for i=1:51
    sample_y_2(i) = 1/(1+25*[sample_x_2(i)]^2);
end
diff = -sample_y_2   % diff = -f  -> and then plus S later

diff(1) = diff(1) + S(alpha(1), beta(1), gamma(1), delta(1), sample_x_2(1), sample_x(1));
for i=2:51
    j = 1+floor((i-2)/5);
    diff(i) = diff(i) + S( alpha(j), beta(j), gamma(j), delta(j), sample_x_2(i), sample_x(j) );
end

plot(sample_x_2, diff)
title('S(x)-f(x)')
grid on

function y = S(alpha, beta, gamma, delta, x, x_i)
    y = alpha*(x-x_i)^3 + beta*(x-x_i)^2 + gamma*(x-x_i) + delta;
end