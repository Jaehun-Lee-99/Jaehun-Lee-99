%20180490 Jaehun LEE
function [L, U, P] = DecompLU_OP_wPP(A)
    % [parameters]
    % x: array
    %   nxn matrix
    % L: array
    %   nxn unit lower triangular matrix
    % U: array
    %   nxn upper triangular matrix
    % P: array
    %   nxn permutation matrix
    
    % An output of the function should satisfy the following:
    % P * x = L * U
    
    %%%%%%% [Write down your code in the following block]
    
    n = size(A,1);
    Ak = A;
    L = eye(n); % L is unit lower triangular
    U = zeros(n);
    P = eye(n);
    for k = 1:n-1
        [~,r] = max(abs(Ak(k:end,k))); % r = the index of the maximum of a part of column
        r = n-(n-k+1)+r; % consider the relative index
        Ak([k r],:) = Ak([r k],:); % exchange the row
        P([k r],:) = P([r k],:);
        L([k r],:) = L([r k],:);
        for i = k+1:n
            L(i,k) = Ak(i,k) / Ak(k,k); % get tau
            for j = 1:n
                U(k,j) = Ak(k,j);
                Ak(i,j) = Ak(i,j) - L(i,k)*Ak(k,j); % subtraction of the rows below the pivot
            end
        end
    end
    U(:,end) = Ak(:,end);
    
    
    %%%%%%%
end


