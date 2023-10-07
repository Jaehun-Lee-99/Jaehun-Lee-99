function [V,D,offVals] = twosideJacobi(A,tol)
% Two-sided Jacobi Algorithm
% Jacobi method for Singular Value Decomposition
% [V,D,offVals] = twosideJacobi(A,tol)
% V'*AV = D
% A: n x n Symmetric matrix
% V: n x n Orthogonal matrix
% off(D)<=tol*norm(A,'fro')

n = length(A);
V = eye(n,n);
delta = tol*norm(A,'fro');
offA = norm(A-diag(diag(A)),'fro');
offVals = offA;
B = A;
while offA>delta
    for p=1:n-1
        for q=p+1:n
            [c,s] = symSchur2(A,p,q);
            %%%%%%% [Write down your code in the following block]    
            J = eye(n);
            J(p,p) = c;
            J(q,p) = -s;
            J(p,q) = s;
            J(q,q) = c;
            
            A = J'*A*J;
            V = V*J;
            %%%%%%% [Write down your code in the following block]
            offA = norm(A-diag(diag(A)),'fro');
            offVals = [offVals;offA];
        end
    end
end
D = A;

end