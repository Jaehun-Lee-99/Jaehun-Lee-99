function [y] = norm_vec(x, ord)
    % [parameters]
    % x: array
    %   Input vector or matrix
    % ord:
    %   Order of the norm. Following order of the norm can be calculated: {0, 1, 2, 'inf'}
    % [returns]
    % y: float
    %   Norm of 'x'
    
    % Do not use MATLAB built-in functions (such as 'norm') except for "sum", "abs", "max"
    if ord == 0
        %%%%%%% [Write down your code in the following block]
        y = 0;
        for i=1:length(x)
            if x(i) ~= 0
                y = y + 1;
            end
        end
        %%%%%%%
    elseif ord == 1
        %%%%%%% [Write down your code in the following block] 
        y = sum(abs(x));
        %%%%%%%
    elseif ord == 2
        %%%%%%% [Write down your code in the following block] 
        y = 0;
        for i=1:length(x)
            y = y + (x(i))^2;
        end
        y = sqrt(y);
        %%%%%%%
    elseif ord == 'inf'
        %%%%%%% [Write down your code in the following block] 
        y = max(abs(x));
        %%%%%%%
    else
        error('Invalid norm order');
    end     
end


