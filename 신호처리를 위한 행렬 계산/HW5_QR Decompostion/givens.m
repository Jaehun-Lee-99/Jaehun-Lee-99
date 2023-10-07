function [c,s] = givens(a,b)
% Givens rotation computation
% [c,s] = givens(a,b)
% cosine-sine pair (c,s)
% [c s;-s c]'*[a;b] = [r;0]
    
    %%%%%%% [Write down your code in the following block]
    
    % if arg(a,b) = t, c = cos(-t) = cos(t), s = sin(-t) = -sin(t)
    r = sqrt(a^2 + b^2);
    c = a/r;
    s = -b/r;
    
%     if b == 0
%         c = 1;
%         s = 0;
%     else
%         if abs(b) > abs(a)
%             t = -a/b;
%             s = 1/sqrt(1+t^2);
%             c = s*t;
%         else
%             t = -b/a;
%             c = 1/sqrt(1+t^2);
%             s = c*t;
%         end          
%     end
%     

    %%%%%%%
end