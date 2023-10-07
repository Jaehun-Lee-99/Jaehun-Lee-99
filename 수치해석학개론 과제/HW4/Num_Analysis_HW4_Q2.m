% 20180490 Jaehun Lee HW4 Q2
clear, clc
format long;

actual = -sin(0.25);

h = 2e-8;
computed = [cos(0.25+h)-cos(0.25)]/h;
Error = abs(computed-actual);
fprintf('Error with h = 2e-8 : %d < 2e-8 \n', Error)


%% To compare with other h values

h1 = 1e-8;
computed1 = [cos(0.25+h1)-cos(0.25)]/h1;
Error1 = abs(computed1-actual);

h2 = 1e-9;
computed2 = [cos(0.25+h2)-cos(0.25)]/h2;
Error2 = abs(computed2-actual);

h3 = 1e-7;
computed3 = [cos(0.25+h3)-cos(0.25)]/h3;
Error3 = abs(computed3-actual);

Error <= Error1
Error < Error2
Error < Error3

