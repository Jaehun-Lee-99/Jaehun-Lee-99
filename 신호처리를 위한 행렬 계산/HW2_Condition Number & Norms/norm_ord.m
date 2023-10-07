function [y] = norm_ord(x, ord)
    % [parameters]
    % x: array
    %   Input vector or matrix
    % ord:
    %   Order of the norm
    % [returns]
    % y: float
    %   Norm of 'x'
    
    if isvector(x)
        y = norm_vec(x, ord);
    elseif ismatrix(x)
        y = norm_mtx(x, ord);
    else
        error('Input size should be 1-D or 2-D')
    end
end


