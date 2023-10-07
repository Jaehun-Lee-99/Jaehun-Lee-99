function y = Durbin(r)
% [parameters]
    % r: array
    %   n x 1 array such that T = toeplitz([1;r(1:n-1)]) is positive definite
    % y: array
    %   n x 1 array that solves T y = -r(n-1:-1:1)
    
    %%%%%%% [Write down your code in the following block]
    
    n = length(r);
    y = zeros(n,1);
    y(1) = -r(1);
    a = -r(1);
    b = 1;
    z = zeros(n-1,1);
    
    for k=1:n-1
        b = (1-a^2) * b;
        a = -(r(k+1) + r(k:-1:1).' * y(1:k))/b;
        z(1:k) = y(1:k) + a * y(k:-1:1);
        y(1:k+1) = [z(1:k); a];
    end
    
    %%%%%%%
end