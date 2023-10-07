function [y] = cond_num(x, ord)
    % [parameters]
    % x: array
    %   Input vector or matrix (real, square)
    % ord:
    %   Order of the condition number. Following order of the condition number can be calculated: {1, 2, 'fro', 'inf'}
    % [returns]
    % y: float
    %   Condition number of 'x'
    
    % You can use the 'inv' function which returns the inverse matrix of
    % the input.
    if ord == 1
        %%%%%%% [Write down your code in the following block] 
        y = norm_mtx(x, 1)*norm_mtx(inv(x),1);
        %%%%%%%
    elseif ord == 2
        %%%%%%% [Write down your code in the following block] 
        y = norm_mtx(x, 2)*norm_mtx(inv(x),2);
        %%%%%%%
    elseif ord == 'fro'
        %%%%%%% [Write down your code in the following block] 
        y = norm_mtx(x, 'fro')*norm_mtx(inv(x),'fro');
        %%%%%%%
    elseif ord == 'inf'
        %%%%%%% [Write down your code in the following block] 
        y = norm_mtx(x, 'inf')*norm_mtx(inv(x),'inf');
        %%%%%%%
    else
        error('Invalid norm order');
    end     
end


