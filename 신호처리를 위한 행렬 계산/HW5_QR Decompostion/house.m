function [v,beta] = house(x)
% Householder vector computation
% [v,beta] = house(x)
% x: Column vector
% v: Householder vector
% beta: scalar value (P = I - beta*v*v')
    
    %%%%%%% [Write down your code in the following block]
    
    n = length(x);
    s = x(2:n).'*x(2:n);
    v = [1; x(2:n)];
    u = sqrt(s + x(1)^2);
    
    if s == 0
        beta = 2;
    else
        if x(1) > 0 % to preserve significant digits
            v(1) = x(1) + u;
        else
            v(1) = x(1) - u;
        end
        beta = 2*abs(v(1))^2/(s + abs(v(1))^2);
        v = v/v(1);
    end

    %%%%%%%
end