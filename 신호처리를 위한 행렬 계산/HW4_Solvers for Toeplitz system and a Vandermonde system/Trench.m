function B = Trench(r)
% [parameters]
    % r: array
    %   n x 1 array such that T = toeplitz([1;r(1:n-1)]) is positive definite
    % B: array
    %   inverse of T
    
    %%%%%%% [Write down your code in the following block]
    
    n = length(r);
    y = Durbin(r(1:n-1));
    B = zeros(n);

    gamma = 1/(1 + r(1:n-1).' * y(1:n-1));
    nu(1:n-1) = gamma * y(n-1:-1:1);
    B(1,1) = gamma;
    B(1,2:n) = nu(n-1:-1:1).';
    
    for i=2:floor((n-1)/2)+1
        for j=i:n-i+1
            B(i,j) = B(i-1,j-1) + (nu(n+1-j)*nu(n+1-i) - nu(i-1)*nu(j-1))/gamma;
        end
    end
    
    for i=1:floor((n-1)/2)
        for j=i:n-i+1
            B(j,i) = B(i,j);
            B(n+1-j,n+1-i) = B(i,j);
            B(n+1-i,n+1-j) = B(i,j);
        end
    end
        

    %%%%%%%
end
  