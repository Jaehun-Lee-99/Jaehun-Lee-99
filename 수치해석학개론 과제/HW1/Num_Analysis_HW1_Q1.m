% 20180490 Jaehun Lee HW1 Q1
clear, clc
x0 = 0;
x1 = pi/2;
f = inline('tan(x)-exp(x)');
n = 0;
while (x1 - x0 >= 0.001)
x2 = (x0+x1)/2;
n = n+1;

if [feval(f,x2)]*[feval(f,x0)] < 0
    x1 = x2;
else
    x0 = x2;
end

end

x1
x2
x2-x1
n
