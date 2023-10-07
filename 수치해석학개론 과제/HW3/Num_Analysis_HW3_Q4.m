% 20180490 Jaehun Lee HW3 Q4
clear, clc

fprintf('correct intergal value = 4/15 = 0.266666666666 \n')

digitsOld = digits(4);

x = linspace(0,1,51);
h = 0.02;

I_tra = 0;
for i=1:50
    I_tra = I_tra + (h/2)*[f(i*h)+f((i+1)*h)];
end
I_tra
fprintf('(a) composite trapezoidal rule : I_tra = %d \n', I_tra)

I_smp = 0;
for i=1:49
    I_smp = I_smp + (h/6)*[f(i*h)+4*f((i+1)*h)+f((i+2)*h)];
end
I_smp

fprintf('(b) composite Simpson''s rule : I_smp = %d \n', I_smp)

function y = f(x)
    y = x.*(1-x)^0.5;
end

