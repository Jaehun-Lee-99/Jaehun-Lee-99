function x = Levinson(r,b)
% [parameters]
    % r: array
    %   n x 1 array such that T = toeplitz([1;r(1:n-1)]) is positive definite
    % b: array
    %   n x 1 array
    % x: array
    %   n x 1 array that solves T x = b
    
    %%%%%%% [Write down your code in the following block]
    
    n = length(r);
    y = zeros(n,1);
    y(1) = -r(1);
    a = -r(1);
    beta = 1;
    x = zeros(n,1);
    x(1) = b(1);
    z = zeros(n-1,1);
    nu = zeros(n-1,1);
    
    for k=1:n-1
        beta = (1-a^2) * beta;
        mu = (b(k+1) - r(1:k).' * x(k:-1:1))/beta;
        nu(1:k) = x(1:k) + mu * y(k:-1:1);
        x(1:k+1) = [nu(1:k); mu];
        
        if k < n-1
            a = -(r(k+1) + r(k:-1:1).' * y(1:k))/beta;
            z(1:k) = y(1:k) + a * y(k:-1:1);
            y(1:k+1) = [z(1:k); a];
        end
    end

    %%%%%%%
end