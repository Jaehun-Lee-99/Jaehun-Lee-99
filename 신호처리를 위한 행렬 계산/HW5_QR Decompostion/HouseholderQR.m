function [Q,R] = HouseholderQR(A)
% Computing QR factorization using Householder vector
% [Q,R] = HouseholderQR(A)
% A = QR 
% A: m x n Matrix
% Q: m x n Orthogonal matrix
% R: n x n Upper triangular matrix
   
    %%%%%%% [Write down your code in the following block]
    
    [m,n] = size(A);
    Q = eye(m);
    for j=1:n-1
        [v, beta] = house(A(j:m,j));
        A(j:m,j:n) = (eye(m-j+1) - beta*(v*v.')) * A(j:m,j:n);
        H = eye(m);
        H(j:m,j:m) = eye(m-j+1) - beta*(v*v.');
        Q = Q*H;
%         if j < m
%             A(j+1:m,j) = v(2:m-j+1);
%         end
%     
    end
    
    R = A;
    

    %%%%%%%
end
