function [c,s] = symSchur2(A,p,q)
% 2x2 symmetric Schur decomposition
% [c,s] = symSchur2(A,p,q)
% q >= p
% A: n x n Symmetric matrix

%%%%%%% [Write down your code in the following block]

    if A(p,q) ~= 0
        tau = (A(q,q)-A(p,p))/(2*A(p,q));
        if tau >= 0
            t = 1/(tau + sqrt(1 + tau^2));
        else
            t = -1/(-tau + sqrt(1 + tau^2));

        end
        c = 1/sqrt(1 + t^2);
        s = t*c;
    else
        c = 1;
        s = 0;
    end
            

%%%%%%% [Write down your code in the following block]

end
