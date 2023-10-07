% DO NOT MODIFY THIS FILE
% We will compare custom functions 'standard_nomral' and
% 'multivaraite_normal' with MATLAB's built-in function 'mvnrnd' by
% plotting two-dimensional normal random samples 
N = 10000;
dim = 2;% DO NOT MODIFY THIS FILE
% We will compare custom functions 'standard_nomral' and
% 'multivaraite_normal' with MATLAB's built-in function 'mvnrnd' by
% plotting two-dimensional normal random samples 
N = 10000;
dim = 2;
mean = [5, 10];
cov = [16, 4; 4 2];

%% custom standard normal
out1 = standard_normal([N, dim]);
subplot(2, 2, 1);
plot(out1(:,1), out1(:,2), '+')
xlim([-4 4])
ylim([-4 4])
title('custom standard normal')

%% built-in standard normal
out2 = mvnrnd([0 0], [1,0; 0 1], 10000);
subplot(2, 2, 2);
plot(out2(:, 1), out2(:, 2), '+')
xlim([-4 4])
ylim([-4 4])
title('built-in standard normal')

%% custom multivariate normal
out3 = multivariate_normal(mean, cov, N);
subplot(2, 2, 3);
plot(out3(:, 1), out3(:, 2), '+')
xlim([-5 15])
ylim([5 15])
title('custom multivariate normal')

%% built-in multivariate normal
subplot(2, 2, 4);
out4 = mvnrnd(mean, cov, N);
plot(out4(:, 1), out4(:, 2),'+')
xlim([-5 15])
ylim([5 15])
title('built-in multivariate normal')


mean = [5, 10];
cov = [16, 4; 4 2];

%% custom standard normal
out1 = standard_normal([N, dim]);
subplot(2, 2, 1);
plot(out1(:,1), out1(:,2), '+')
xlim([-4 4])
ylim([-4 4])
title('custom standard normal')

%% built-in standard normal
out2 = mvnrnd([0 0], [1,0; 0 1], 10000);
subplot(2, 2, 2);
plot(out2(:, 1), out2(:, 2), '+')
xlim([-4 4])
ylim([-4 4])
title('built-in standard normal')

%% custom multivariate normal
out3 = multivariate_normal(mean, cov, N);
subplot(2, 2, 3);
plot(out3(:, 1), out3(:, 2), '+')
xlim([-5 15])
ylim([5 15])
title('custom multivariate normal')

%% built-in multivariate normal
subplot(2, 2, 4);
out4 = mvnrnd(mean, cov, N);
plot(out4(:, 1), out4(:, 2),'+')
xlim([-5 15])
ylim([5 15])
title('built-in multivariate normal')
