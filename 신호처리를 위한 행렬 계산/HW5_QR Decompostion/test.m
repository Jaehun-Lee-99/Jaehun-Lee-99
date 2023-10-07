% DO NOT MODIFY THIS FILE
rng(1234);
clc;

%% Generating Matrix A
fprintf('Test case\n')
A = randn(4,4);
disp('A ='); disp(A);

%% Test QR Factorization: MATLAB build-in function
fprintf('QR Factorization using MATLAB build-in function ''qr''\n')
[Q,R] = qr(A);
disp('Q ='); disp(Q);
disp('R ='); disp(R);
fprintf('||Q''Q - I|| = %.5f\n',max(svd(Q'*Q-eye(4,4))))
% Distance: using the largest singular value
distQR = max(svd(A-Q*R));
fprintf('||A - QR|| = %.5f\n\n',distQR);

%% Test QR Factorization: using Householder Vector
fprintf('QR Factorization based on Householder Vector\n')
[Q,R] = HouseholderQR(A);
disp('Q ='); disp(Q);
disp('R ='); disp(R);
fprintf('||Q''Q - I|| = %.5f\n',max(svd(Q'*Q-eye(4,4))))
% Distance: using the largest singular value
distQR = max(svd(A-Q*R));
fprintf('||A - QR|| = %.5f\n\n',distQR);

%% Test QR Factorization: using Givens rotation
fprintf('QR Factorization based on Givens Rotations\n')
[Q,R] = GivensQR(A);
disp('Q ='); disp(Q);
disp('R ='); disp(R);
fprintf('||Q''Q - I|| = %.5f\n',max(svd(Q'*Q-eye(4,4))))
% Distance: using the largest singular value
distQR = max(svd(A-Q*R));
fprintf('||A - QR|| = %.5f\n\n',distQR);

%% Test QR factorization of an upper Hessenberg matrix.
fprintf('QR Factorization for an upper Hessenberg matrix based on Givens Rotation.\n')
H = hess(A);
disp('Hessenberg matrix, H'); disp(H);
[Q,R] = HessenbergQR(H);
disp('Q ='); disp(Q);
disp('R ='); disp(R);
fprintf('||Q''Q - I|| = %.5f\n',max(svd(Q'*Q-eye(4,4))))
% Distance: using the largest singular value
distQR = max(svd(H-Q*R));
fprintf('||H - QR|| = %.5f\n\n',distQR);