function z = Vsolve(x,b)
% [parameters]
    % x: array
    %   1 x (n+1) array which has distinct entries
    % b: array
    %   (n+1) x 1 array
    % z: array
    %   (n+1) x 1 array that solves  V z = b where V = Vandermonde(x)
    
    %%%%%%% [Write down your code in the following block]        
    
    n = length(x);
    z = b;
    
    for k=1:n-1
        for i=n:-1:k+1
            z(i) = z(i) - x(k) * z(i-1);
        end
    end
    for k=n-1:-1:1
        for i=k+1:n
            z(i) = z(i)/(x(i) - x(i-k));
        end
        for i=k:n-1
            z(i) = z(i) - z(i+1);
        end
    end
    

    %%%%%%%
end