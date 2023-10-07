% DO NOT MODIFY THIS FILE
rng(1234);
clc;
%% Test the Toeplitz algorithms Durbin, Levinson, and Trench
n = 5;
c = randn(n, 1);

% Generate a Toeplitz matrix
T = Toeplitz(c);
T = T / T(1,1);

disp('Toeplitz matrix T = ')
disp(T)

r = T(2:n,1);
r(n) = rand(1);

% Durbin
y = Durbin(r);
fprintf('||Durbin(r)  - T\\(-r)|| = %10.3e\n\n', norm(y - T\(-r)))

% Levinson
b = randn(n,1);
x = Levinson(r,b);
fprintf('||Levinson(r,b) - T\\b|| = %10.3e\n\n', norm(x - T\b))

% Trench
B = Trench(r);
fprintf('||Trench(r) - inv(T)|| = %10.3e\n\n',norm(B - inv(T)))


%% Test Vandermonde system solving
n = 4;
x = randn(1, n+1);

% Generate a Vandermonde matrix
V = Vandermonde(x);

disp('Vandermonde matrix V = ')
disp(V)

% Solve V' a = f
f = randn(n+1, 1);
a = VTsolve(x,f);
fprintf('||VTSolve(x,f) - V''\\f|| = %10.3e\n\n',norm(a - V'\f))

% Solve V z = b 
b = randn(n+1, 1);
z = Vsolve(x,b);
fprintf('||VSolve(x,b) - V\\b||    = %10.3e\n\n',norm(z - V\b))