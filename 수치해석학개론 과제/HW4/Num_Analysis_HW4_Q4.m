% 20180490 Jaehun Lee HW4 Q4
clear, clc

% from Q3, we got y = xlnx + 2x
%% get exact y values from the equation above

% get y values when h = 1/10
sample_x1 = linspace(1,2,11);
sample_y1 = zeros(1,11);
for i=1:11
    sample_y1(i) = sample_x1(i)*log(sample_x1(i)) + 2*sample_x1(i);
end

% get y values when h = 1/20
sample_x2 = linspace(1,2,21);
sample_y2 = zeros(1,21);
for i=1:21
    sample_y2(i) = sample_x2(i)*log(sample_x2(i)) + 2*sample_x2(i);
end

% get y values when h = 1/40
sample_x3 = linspace(1,2,41);
sample_y3 = zeros(1,41);
for i=1:41
    sample_y3(i) = sample_x3(i)*log(sample_x3(i)) + 2*sample_x3(i);
end

h1 = 1/10;
h2 = 1/20;
h3 = 1/40;

%% Solving with improved Euler's method

% Improved Euler's method : yi+1 = yi + h/2 * [f(xi, yi) + f(xi+1, yi + h*f(xi,yi))]
% f(x,y) = 1 + y/x , y(1) = 2

% h = 1/10
Euler_y1 = zeros(1,11);
Euler_y1(1) = 2;
for i=1:10
    Euler_y1(i+1) = Euler_y1(i) + (h1/2)*[f(sample_x1(i), Euler_y1(i)) + f(sample_x1(i+1), (Euler_y1(i) + h1*f(sample_x1(i), Euler_y1(i))))];
end
E1 = Euler_y1 - sample_y1;  % Error for each point when h = 1/10
E_max1 = max(abs(E1)); % max of absolute error

% h = 1/20
Euler_y2 = zeros(1,21);
Euler_y2(1) = 2;
for i=1:20
    Euler_y2(i+1) = Euler_y2(i) + (h2/2)*[f(sample_x2(i), Euler_y2(i)) + f(sample_x2(i+1), (Euler_y2(i) + h2*f(sample_x2(i), Euler_y2(i))))];
end
E2 = Euler_y2 - sample_y2;  % Error for each point when h = 1/20
E_max2 = max(abs(E2));  % max of absolute error

% h = 1/40
Euler_y3 = zeros(1,41);
Euler_y3(1) = 2;
for i=1:40
    Euler_y3(i+1) = Euler_y3(i) + (h3/2)*[f(sample_x3(i), Euler_y3(i)) + f(sample_x3(i+1), (Euler_y3(i) + h3*f(sample_x3(i), Euler_y3(i))))];
end
E3 = Euler_y3 - sample_y3;  % Error for each point when h = 1/40
E_max3 = max(abs(E3));  % max of absolute error

%% Error Analysis

% with maximum values
fprintf('ratio of maximum error : E_max2/E_max1 = %d  ~0.25\n',E_max2/E_max1)
fprintf('ratio of maximum error : E_max3/E_max2 = %d  ~0.25\n',E_max3/E_max2)
fprintf('ratio of maximum error : E_max3/E_max1 = %d  ~0.0625\n\n',E_max3/E_max1)

% avarage of error ratio
R1 = zeros(1,9); % E2/E1
R2 = zeros(1,9); % E3/E2
R3 = zeros(1,9); % E3/E1
for i=1:10
    R1(i) = E2(2*i+1)/E1(i+1);
end
fprintf('average ratio of error (E2/E1) = %d  ~0.25\n',mean(R1))
for i=1:20
    R2(i) = E3(2*i+1)/E2(i+1);
end
fprintf('average ratio of error (E3/E2) = %d  ~0.25\n',mean(R2))
for i=1:9
    R3(i) = E3(4*i+1)/E1(i+1);
end
fprintf('average ratio of error (E3/E2) = %d  ~0.0625\n',mean(R3))


function y_p = f(x,y)
    y_p = 1 + y/x;
end