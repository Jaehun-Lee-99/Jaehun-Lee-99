function [Q,R] = HessenbergQR(A)
% QR factorization of an upper Hessenberg matrix via Givens Rotations
% [Q,R] = HessenbergQR(A)
% A = QR 
% A: n x n Matrix
% Q: n x n Orthogonal matrix
% R: n x n Upper triangular matrix with nonnegative diagonal entries
   
    %%%%%%% [Write down your code in the following block]
    
    % A is a Hessenberg matrix
    
    n = length(A(:,1));
    Q = eye(n);
    for j=1:n-1
        [c,s] = givens(A(j,j),A(j+1,j));
        A(j:j+1,j:n) = [c s; -s c].'*A(j:j+1,j:n);
        G = eye(n);
        G(j:j+1,j:j+1) = [c s; -s c];
        Q = Q*G;
    end
    R = A;

    %%%%%%%
end