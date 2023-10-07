function [Q,R] = GivensQR(A)
% Computing QR factorization using Givens rotation
% [Q,R] = GivensQR(A)
% A = QR 
% A: m x n Matrix
% Q: m x m Orthogonal matrix
% R: m x n Upper triangular matrix
   
    %%%%%%% [Write down your code in the following block]
    
    [m,n] = size(A);
    Q = eye(m);
    for j=1:n
        for i=m:-1:j+1
            [c,s] = givens(A(i-1,j),A(i,j));
            G = eye(m);
            G(i-1:i,i-1:i) = [c s; -s c];
            Q = Q*G; % Q = G1*G2*...*Gn
            A(i-1:i,j:n) = [c s; -s c].'*A(i-1:i,j:n);
        end
    end
    R = A;

    %%%%%%%
end



