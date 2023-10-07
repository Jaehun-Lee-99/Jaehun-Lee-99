% DO NOT MODIFY THIS FILE
rng(1234);
close all;
clc;
%% Generating Matrix A
fprintf('Test case\n')
n = 3; 
A = randn(n,n);
A = A + A';
tol = 10^(-16);
disp('A ='); disp(A);

%% Illustrates the convergence of the Two-sided Jacobi methods
figure
[V,D,offVals] = twosideJacobi(A,tol);
m = length(offVals);
semilogy((1:m),offVals)
ylabel('off(A)','fontsize',11)
xlabel('Updates','fontsize',11)
title(sprintf('Two-sided Jacobi algorithm   n=%1d   tol=%10.3e   updates = %1d',n,tol,m),'fontsize',11)

%% Test
dist = max(svd(A-V*D*V')); % Distance
fprintf('||A - V*D*V^T|| = %.5f\n\n',dist);
dist = max(svd(eye(n,n)-V'*V)); % Distance
fprintf('||I - V^T*V|| = %.5f\n\n',dist);
disp('D ='); disp(D);

[U,S,V] = svd(A);
dist = max(svd(A-U*S*V')); % Distance
fprintf('||A - USV^T|| = %.5f\n\n',dist);
disp('S ='); disp(S);

% l = length(offVals);
% lin = zeros(1,l-1);
% quad = zeros(1,l-1);
% for i=1:l-1
%     lin(i) = offVals(i+1)/offVals(i);
%     quad(i) = offVals(i+1)/offVals(i)^2;
% end
% figure
% plot(lin)
% title('offVals(i+1)/offVals(i)')
% xlabel('i')