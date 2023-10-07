% 20180490 Jaehun Lee HW2_Q1
clear, clc
% Muller Method
f = inline('8*x^3 - 12*x^2 -50*x + 75');
%{
feval(f,-3) % = -99
feval(f,-2) % = 63
feval(f,-1) % = 105
feval(f,0)  % = 75
feval(f,1)  % = 21
feval(f,2)  % = -9
feval(f,3)  % = 33
%}
% f(-3)f(-2)<0, f(1)f(2)<0, f(2)f(3)<0

% WE SHOULD CHANGE THE INPUTS (x0 AND x2) AND SEE HOW THE RESULT CHANGES

Guess = [-4, -1.5, 0, 2, 2.4, 3];
for i = 1:5
    % set initial interval
    x0 = Guess(1,i);
    x2 = Guess(1,i+1);
    x1 = (x0+x2)/2;
    
    INIT = [x0, x2]; %save the initial values
    n = 0;
    
    if x2 == 0
        continue
    end
    
    while abs((x2-x0)/x2) >= 1e-4 % do the Muller method till the relative difference < 10^-4
        n = n+1;
        [x0, x1, x2] = Muller(x0,x1,x2,f);
    end
    formatSpec = 'Initial interval : [%2.6f, %2.6f]\nFinal interval : [%2.6f, %2.6f]\nfound a zero at x = %2.6f with %d iterations\n\n';
    fprintf(formatSpec,INIT,x0,x2,x2,n)

end

function [x1, x2, x3] = Muller(x0,x1,x2,f)
if (x0 == x1) || (x1 == x2) || (x2 == x0)
    fprintf('finished')
    return
end
% get the coefficents of the quadratic eq that passes x0, x1, and x2
a = [(x1-x2)*(feval(f,x0)-feval(f,x2))-(x0-x2)*(feval(f,x1)-feval(f,x2))]/ ... 
    [(x0-x1)*(x1-x2)*(x0-x2)];
if a == 0
    fprintf('error\n')
    return
end
b = [(x0-x2)^2*(feval(f,x1)-feval(f,x2))-(x1-x2)^2*(feval(f,x0)-feval(f,x2))]/ ... 
    [(x0-x1)*(x1-x2)*(x0-x2)];
c = feval(f,x2);
Q = inline('a*(x-x2)^2+b*(x-x2)+c');

%find the root of Q
r1 =  -(b + (b^2 - 4*a*c)^(1/2))/(2*a);
r2 =  -(b - (b^2 - 4*a*c)^(1/2))/(2*a);

%set x3 closer to x2
if abs(r1) <= abs(r2)
    x3 = x2 + r1;
else 
    x3 = x2 + r2;
end

if x3 <= x2
    x2 = (x1+x3)/2;
end
    
end

