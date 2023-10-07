% 20180490 Jaehun Lee HW2_Q4
clear, clc

fprintf('(a) By doing Gaussian elimination, we get the solution\n')
fprintf('X = [-124; 1560; -3960; 2660]\n')

%(a) By doing Gaussian elimination, we get the solution
% X = [-124; 1560; -3960; 2660] 

digitsOld = digits(5);

H = [vpa(1), vpa(1/2), vpa(1/3), vpa(1/4); ...
    vpa(1/2), vpa(1/3), vpa(1/4), vpa(1/5); ...
    vpa(1/3), vpa(1/4), vpa(1/5) vpa(1/6); ...
    vpa(1/4), vpa(1/5), vpa(1/6), vpa(1/7)];
b = [1; 0; 0; 1];
x = H\b;
fprintf('From MATLAB Calculation, we get\n')
fprintf('x = [%d; %d; %d; %d]\n', x)
fprintf('despite of the five digit rounding, we get the correct answer\n')

H_inv = inv(H);

norm_H = 0;
norm_H_inv = 0;
for i=1:4
    for j=1:4
        norm_H = norm_H + (H(i,j))^2;
        norm_H_inv = norm_H_inv + (H_inv(i,j))^2;
    end
end
norm_H = sqrt(norm_H);
norm_H_inv = sqrt(norm_H_inv);
condition_num_H = norm_H * norm_H_inv;
% K(H) with Frebnius norm = 15614 -> the condition number is quite large.

fprintf('(b)\n')
fprintf('K_inf(H) = 1 + 1/2 + 1/3 + 1/4 = 25/12 = 2.0833\n')
fprintf('By the way, K(H) with Frebnius norm = 15614 -> the condition number is quite large\n')