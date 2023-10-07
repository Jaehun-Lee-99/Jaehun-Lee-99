% 20180490 Jaehun Lee HW3 Q1
clear, clc

% interpolates the Runge function -> f = 1/(1+25x^2)
% Newton interpolating polynomial P
% P = b0+b1(x-x0)+b2(x-x0)(x-x1)+ ... +bn(x-x0)...(x-x_n-1) 

% [x0,x1,...,xn-1]
sample_x = linspace(-1,1,11);
% [y0,y1,...,yn-1]
sample_y = zeros(1,11);
for i=1:11
    sample_y(i) = 1/(1+25*[sample_x(i)]^2);
end

b = sample_y;

for i=1:10
    for j=11:-1:i+1
        b(j) = [b(j)-b(j-1)]/[sample_x(j)-sample_x(j-i)];
    end
end

sample_x_2 = linspace(-1,1,51);
sample_y_2 = zeros(1,51);
for i=1:51
    sample_y_2(i) = 1/(1+25*[sample_x_2(i)]^2);
end
P = p(sample_x_2);
diff = P - sample_y_2
plot(sample_x_2,diff)
grid on
title('P(x)-f(x)')

function y = p(x)
    % from the value of b
    y = 0.038461538461538 ...
        +0.101809954751131.*(x+1) ...
        +0.260180995475113.*(x+1).*(x+0.8) ...
        +0.791855203619908.*(x+1).*(x+0.8).*(x+0.6) ...
        +2.686651583710411.*(x+1).*(x+0.8).*(x+0.6).*(x+0.4) ...
        -6.363122171945710.*(x+1).*(x+0.8).*(x+0.6).*(x+0.4).*(x+0.2) ...
        -17.675339366515814.*(x+1).*(x+0.8).*(x+0.6).*(x+0.4).*(x+0.2).*x ...
        +84.841628959275970.*(x+1).*(x+0.8).*(x+0.6).*(x+0.4).*(x+0.2).*x.*(x-0.2) ...
        -167.9157239819003.*(x+1).*(x+0.8).*(x+0.6).*(x+0.4).*(x+0.2).*x.*(x-0.2).*(x-0.4) ...
        +220.9417420814478.*(x+1).*(x+0.8).*(x+0.6).*(x+0.4).*(x+0.2).*x.*(x-0.2).*(x-0.4).*(x-0.6) ...
        -220.9417420814478.*(x+1).*(x+0.8).*(x+0.6).*(x+0.4).*(x+0.2).*x.*(x-0.2).*(x-0.4).*(x-0.6).*(x-0.8);
end
