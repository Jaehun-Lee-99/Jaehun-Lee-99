function T = Toeplitz(c)
% [parameters]
    % c: array
    %   n x 1 size first column of a Toeplitz matrix
    % T: array
    %   n x n Toeplitz matrix
    
    %%%%%%% [Write down your code in the following block]
    
    n = length(c);
    T = zeros(n);
    
    T(1,:) = c.';
    for i=2:n
        for j=1:n
           T(i,j) = T(1,abs(i-j)+1);
        end
    end
    %%%%%%%
end


