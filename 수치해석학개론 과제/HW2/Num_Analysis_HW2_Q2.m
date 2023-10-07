% 20180490 Jaehun Lee HW2_Q2
clear, clc

% (a)
y = 1e10;
a = (y-(y^2-1)^0.5);
b = 1/(y+(y^2-1)^0.5); %multiply y+(y^2-1)^0.5 to both numerator and denominator
fprintf('Q2.(a)\n')
fprintf('Before rearranging : %2.40f\nAfter rearranging : %2.40f\n', a, b)
fprintf('\n')

% (b)
% cos^3(x) = (cos3x + 3cosx)/4
theta = 1e-8;
a = 1 - cos(theta).^3;
b = 1 - (cos(3*theta) + 3*cos(theta))/4;
fprintf('Q2.(b)\n')
fprintf('Before rearranging : %2.40f\nAfter rearranging : %2.40f\n', a, b)
fprintf('\n')

%(c)
% z^2 -200z + 10001 = (z-100)^2 + 1
z_p = 100 + 1e-7;
z_m = 100 - 1e-6;
a = z_p^2 - 200*z_p + 10001;
b = (z_p - 100)^2 + 1;
c = z_m^2 - 200*z_m + 10001;
d = (z_m - 100)^2 + 1;
fprintf('Q2.(c)\n')
fprintf('for z_p\n')
fprintf('Before rearranging : %2.40f\nAfter rearranging : %2.40f\n', a, b)
fprintf('for z_m\n')
fprintf('Before rearranging : %2.40f\nAfter rearranging : %2.40f\n', c, d)
