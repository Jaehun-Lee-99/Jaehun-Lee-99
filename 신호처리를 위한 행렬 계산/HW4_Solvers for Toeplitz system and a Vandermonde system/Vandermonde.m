  function V = Vandermonde(x)
% [parameters]
    % x: array
    %   1 x (n+1) array which has distinct entries
    % V: array
    %   (n+1) x (n+1) Vandermonde matrix with V(i,j) = x(j)^{i-1}
    %   ex) [1 1 1; 2 3 4; 4 9 16]
    
    %%%%%%% [Write down your code in the following block]
    
    n = length(x);
    V = zeros(n);
    for i=1:n
        for j=1:n
            V(i,j) = x(j)^(i-1);
        end
    end

    %%%%%%%
end