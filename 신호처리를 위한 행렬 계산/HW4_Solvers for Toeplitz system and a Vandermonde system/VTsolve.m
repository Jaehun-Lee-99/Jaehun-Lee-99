function a = VTsolve(x, f)
% [parameters]
    % x: array
    %   1 x (n+1) array which has distinct entries
    % f: array
    %   (n+1) x 1 array
    % a: array
    %   (n+1) x 1 array that solves  V' a = f where V = Vandermonde(x)
    
    %%%%%%% [Write down your code in the following block]
    
    n = length(x);
    a = f;
    
    for k=1:n-1
        for i=n:-1:k+1
            a(i) = (a(i)-a(i-1))/(x(i)-x(i-k));
        end
    end
    
    for k=n-1:-1:1
        for i=k:n-1
            a(i) = a(i) - a(i+1) * x(k);
        end
    end
    

    %%%%%%%
end