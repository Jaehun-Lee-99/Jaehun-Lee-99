% 20180490 Jaehun Lee HW2_Q3
clear, clc

A = [6, 2, 1, -1, 1; 2, 4, 1, 0, 0; 1, 1, 4, -1, 0; -1, 0, -1, 3, 0; 1, 0, 0, 0, 1];

% what I got by hand - referred to my HW pdf file
R5 = [sqrt(6), sqrt(6)/3, 1/sqrt(6), -1/sqrt(6), 1/sqrt(6); ...
    0, sqrt(30)/3, sqrt(30)/15, 1/sqrt(30), -1/sqrt(30); ...
    0, 0, sqrt(370)/10, -9/sqrt(370), -1/sqrt(370); ...
    0, 0, 0, sqrt(191/74), 13/sqrt(14134); ...
    0, 0, 0, 0, sqrt(150/191)];

R = chol(A);

disp(R5 - R)
% error occurs because of the loss of significant digits
% error for each entry is less than 10^-15


% Another algorithm to get chol(A)

% count = 0;
% [n,n] = size(A);
% R=zeros(n,n)
% for j=1:n
%     for i=1:j-1
%         sum1 = 0;
%         for k=1:i-1
%             sum1 = sum1 + R(k,i)*R(k,j);
%         end
%         R(i,j)=(A(i,j)-sum1)/R(i,i);
%     end
%     sum2 = 0;
%     for k=1:j-1 
%         sum2 = sum2 + R(k,j)*R(k,j);
%     end
%     R(j,j)=sqrt(A(j,j)-sum2);
% end
% Q=transpose(R);
% S=Q*R;
% R

