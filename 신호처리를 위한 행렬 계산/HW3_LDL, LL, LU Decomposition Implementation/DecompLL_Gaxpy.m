%20180490 Jaehun LEE
function [L] = DecompLL_Gaxpy(x)
    % [parameters]
    % x: array
    %   nxn symmetric and postivie defeinite matrix
    % L: array
    %   nxn lower triangular matrix
    
    % An output of the function should satisfy the following:
    % x = L * L'
    
    %%%%%%% [Write down your code in the following block]
    n = size(x,1);
    L = zeros(n);
    L(1,1) = sqrt(x(1,1)); % initialize
    %get L(i,j) for i>j
    for i=2:n
        for j=1:i-1
            L(i,j) = x(i,j);
            for k=1:j-1
                L(i,j) = L(i,j) - L(i,k)*L(j,k);
            end
            L(i,j) = L(i,j)/L(j,j);
        end
        % get the diagonal enrty L(i,i)
        L(i,i) = x(i,i);
        for j=1:i-1
            L(i,i) = L(i,i) - L(i,j)^2;
        end
        L(i,i) = sqrt(L(i,i));
    end
    
    %%%%%%%
end


