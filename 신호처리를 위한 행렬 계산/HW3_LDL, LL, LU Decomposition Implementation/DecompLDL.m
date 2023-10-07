%20180490 Jaehun LEE
function [L, D] = DecompLDL(x)
    % [parameters]
    % x: array
    %   nxn symmetric and postivie defeinite matrix
    % L: array
    %   nxn unit lower triangular matrix
    % D: array
    %   nxn diagonal matrix
    
    % An output of the function should satisfy the following:
    % x = L * D * L'
    
    %%%%%%% [Write down your code in the following block]
    
    n = size(x,1);
    L = eye(n); % L is unit lower triangular
    D = eye(n);
    D(1,1) = x(1,1);
    % get L(i,j) for i>j
    for i=2:n
        for j=1:i-1
            L(i,j) = x(i,j);
            for k=1:j-1
                L(i,j) = L(i,j) - L(i,k)*L(j,k)*D(k,k);
            end
            L(i,j) = L(i,j)/D(j,j);
        end 
        % get Diagonal entry for D
        D(i,i) = x(i,i);
        for j=1:i-1
            D(i,i) = D(i,i) - L(i,j)^2*D(j,j);
        end
    end
    
    
    
    %%%%%%%
end

