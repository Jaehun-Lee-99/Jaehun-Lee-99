% DO NOT MODIFY THIS FILE
clear; clc;

x = [1.7177 0.8159 1.3509 1.1841; 0.8158 1.1518 1.0347 1.2366; 1.3509 1.0347 1.7615 1.7600; 1.1841 1.2366 1.7600 1.8842];

%% built-in LDL factorization function
disp('LDL factorization')
[L, D] = DecompLDL(x);
disp("L:")
disp(L)
disp("D:")
disp(D)
disp("L * D * L':")
disp(L * D * L')
disp("x:")
disp(x)

%% built-in Cholesky factorization function
disp('Cholesky factorization')
[L] = DecompLL_Gaxpy(x);
disp("L:")
disp(L)
disp("L * L':")
disp(L * L')
disp("x:")
disp(x)

%% built-in LU function
disp('LU factorization')
[L, U, P] = DecompLU_OP_wPP(x);
disp("L:")
disp(L)
disp("U:")
disp(U)
disp("L * U:")
disp(L * U)
disp("P * x:")
disp(P * x)