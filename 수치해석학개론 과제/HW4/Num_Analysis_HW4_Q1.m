% 20180490 Jaehun Lee HW4 Q1
clear, clc

I_actual = (pi+2)/8;

% Int 0~pi/4  cos^2(x) dx = Int -1~1 pi/8*cos^2(pi/8*t+pi/8) dt
% f(t) = pi/8 * (cos(pi/8*t + pi/8))^2

%% Using higher order quadrature

I = zeros(1,8);
E = zeros(1,8);

% n = 1
I(1) = 2*f(0);
E(1) = I(1) - I_actual;

% n = 2
I(2) = f(-1/sqrt(3)) + f(1/sqrt(3));
E(2) = I(2) - I_actual;

% n = 3
I(3) = 8/9*f(0) + 5/9*f(-sqrt(3/5)) + 5/9*f(sqrt(3/5));
E(3) = I(3) - I_actual;

% n = 4
I(4) = (18+sqrt(30))/36*f(-sqrt(3/7-2/7*sqrt(6/5))) + (18+sqrt(30))/36*f(sqrt(3/7-2/7*sqrt(6/5)))...
    + (18-sqrt(30))/36*f(-sqrt(3/7+2/7*sqrt(6/5))) + (18-sqrt(30))/36*f(sqrt(3/7+2/7*sqrt(6/5)));
E(4) = I(4) - I_actual;

% n = 5
I(5) = 128/225*f(0) ...
    + (322+13*sqrt(70))/900*f(-1/3*sqrt(5-2*sqrt(10/7))) + (322+13*sqrt(70))/900*f(1/3*sqrt(5-2*sqrt(10/7)))...
    + (322-13*sqrt(70))/900*f(-1/3*sqrt(5+2*sqrt(10/7))) + (322-13*sqrt(70))/900*f(1/3*sqrt(5+2*sqrt(10/7)));
E(5) = I(5) - I_actual;

% n = 6
I(6) = 0.1713244924*f(-0.9324695142) + 0.1713244924*f(0.9324695142)...
    + 0.3607615730*f(-0.6612093865) + 0.3607615730*f(0.6612093865)...
    + 0.4679139346*f(-0.2386191861) + 0.4679139346*f(0.2386191861);
E(6) = I(6) - I_actual;

% n = 7
I(7) = 0.1294849662*f(-0.9491079123) + 0.1294849662*f(0.9491079123)...
    + 0.2797053915*f(-0.7415311856) + 0.2797053915*f(0.7415311856)...
    + 0.3818300505*f(-0.4058451514) + 0.3818300505*f(0.4058451514)...
    + 0.4179591837*f(0);

E(7) = I(7) - I_actual;

% n = 8
I(8) = 0.1012285363*f(-0.9602898565) + 0.1012285363*f(0.9602898565)...
    + 0.2223810345*f(-0.7966664774) + 0.2223810345*f(0.7966664774)...
    + 0.3137066459*f(-0.5255324099) + 0.3137066459*f(0.5255324099)...
    + 0.3626837834*f(-0.1834346425) + 0.3626837834*f(0.1834346425);

E(8) = I(8) - I_actual;

fprintf('----Error for higher order quadrature----\n')
fprintf('Error when n is 1 = %d\n', E(1))
fprintf('Error when n is 2 = %d\n', E(2))
fprintf('Error when n is 3 = %d\n', E(3))
fprintf('Error when n is 4 = %d\n', E(4))
fprintf('Error when n is 5 = %d\n', E(5))
fprintf('Error when n is 6 = %d\n', E(6))
fprintf('Error when n is 7 = %d\n', E(7))
fprintf('Error when n is 8 = %d\n\n', E(8))

R = zeros(1,7);
for i=1:7
    R(i) = E(i+1)/E(i);
end
R

%% Using the composite Gaussian quadrature

I_c = zeros(1,8);
E_c = zeros(1,8);

for i = 1:8
    I_c(i) = g(i,-1/sqrt(3)) + g(i,1/sqrt(3));
    E_c(i) = I_c(i) - I_actual;
end
%plot(abs(E_c))

R_c = zeros(1,7);
for i=1:7
    R_c(i) = E_c(i+1)/E_c(i);
end
R_c

fprintf('----Error for composite Gaussian quadrature----\n')
fprintf('Error when node is 2 = %d\n', E_c(1))
fprintf('Error when node is 3 = %d\n', E_c(2))
fprintf('Error when node is 4 = %d\n', E_c(3))
fprintf('Error when node is 5 = %d\n', E_c(4))
fprintf('Error when node is 6 = %d\n', E_c(5))
fprintf('Error when node is 7 = %d\n', E_c(6))
fprintf('Error when node is 8 = %d\n', E_c(7))
fprintf('Error when node is 9 = %d\n', E_c(8))



%% functions

function y = f(t)
    y = pi/8 * (cos(pi/8*t + pi/8))^2 ;
end

function y = g(n,t)
    y=0;
    for i=1:n
        y = y + pi/(8*n)*(cos(pi/(8*n)*t+(2*i-1)/(8*n)*pi))^2;
    end
end