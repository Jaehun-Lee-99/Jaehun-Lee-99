function [y] = norm_mtx(x, ord)
    % [parameters]
    % x: array
    %   Input vector or matrix (real)
    % ord:
    %   Order of the norm. Following order of the norm can be calculated: {1, 2, 'fro', 'inf'}
    % [returns]
    % y: float
    %   Norm of 'x'
    
    % do not use MATLAB built-in functions except for "sum", "abs", "max"
    % use custom function "norm_vec" to obtain matrix norm
    [row_dim, col_dim] = size(x);
    if ord == 'fro'
        %%%%%%% [Write down your code in the following block]
        y = 0;
        for i=1:row_dim
            for j=1:col_dim
                y = y + x(i,j)^2;
            end
        end
        y = sqrt(y);
        %%%%%%%
    elseif ord == 1
        %%%%%%% [Write down your code in the following block] 
        y = max(sum(abs(x)));
        %%%%%%%
    elseif ord == 2
        % We will find the largest singular value of a matrix with the
        % 'power iteration method'. Explain the reason along the code why
        % such method works
        %%%%%%%
        N = 100;
        v = rand(col_dim, 1);
        for i = 1:N
            t = x.' * x * v;
            v = t / norm_vec(t, 2);
        end
        y = norm_vec(x * v, 2);
        %%%%%%%
    elseif ord == 'inf'
        %%%%%%% [Write down your code in the following block] 
        y = max(sum(abs(x),2));
        %%%%%%%
    else
        error('Invalid norm order');
    end     
end


