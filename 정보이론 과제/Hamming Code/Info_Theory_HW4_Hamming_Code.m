%% 이재헌 정보이론 및 부호화 개론 HW4 Hamming Code
clc; clear all;

%% Q1

rand_num1 = zeros(10000,4); % random 4-bit sequences 
[row, col] = size(rand_num1);
for i=1:row
    for j=1:col
        rand_num1(i,j) = randi([0,1],1);
    end
end

H1 = [1 0 0 1 1 0 1; ...
      0 1 0 0 1 1 1;...
      0 0 1 1 0 1 1];
A1 = H1(:,4:7);
G1 = [transpose(A1) eye(4)];
p = [10^-3:10^-3:9*10^-3 10^-2:10^-2:9*10^-2 10^-1:10^-1:5*10^-1];
P_u = zeros(1,length(p));
P_dc = zeros(1,length(p));
P_du = zeros(1,length(p));
P_e = zeros(1,length(p));

for i=1:length(p)
    transmitted1 = generating_codewords(rand_num1, G1); % original signal
    received1 = bin_sym_chan(transmitted1,p(i)); % signal with channel noise
    estimated1 = correcting(H1,received1); % estimated signal
    [P_u(i), P_dc(i), P_du(i)] = Rates(transmitted1, received1, estimated1, H1);
    P_e(i) = 1 - ( (1-p(i))^7+7*(1-p(i))^6*p(i) ) ;
end

P_t = P_u + P_du;

% plot

figure(1); 
subplot(2,2,1);
loglog(p, P_u);
grid on
title('P_u of (7,4,3)');
xlabel('p')
ylabel('P_u')

subplot(2,2,2);
loglog(p, P_dc);
grid on
title('P_d_c of (7,4,3)');
xlabel('p')
ylabel('P_d_c')

subplot(2,2,3);
loglog(p, P_du);
grid on
title('P_d_u of (7,4,3)');
xlabel('p')
ylabel('P_d_u')

subplot(2,2,4);
loglog(p, P_u + P_du);
grid on
title('P_t of (7,4,3)');
xlabel('p')
ylabel('P_t')

figure(2)
plot(p,P_u + P_du - P_e);
title('P_t - P_e of (7,4,3)')
grid on
xlabel('p')
ylabel('P_t - P_e')


%% Q2

rand_num2 = zeros(10000,11); % random 11-bit sequences 
[row, col] = size(rand_num2);
for i=1:row
    for j=1:col
        rand_num2(i,j) = randi([0,1],1);
    end
end

H2 = [1 0 0 0 0 0 0 0 1 1 1 1 1 1 1; ...
      0 1 0 0 0 1 1 1 0 0 0 1 1 1 1; ...
      0 0 1 0 1 0 1 1 0 1 1 0 0 1 1; ...
      0 0 0 1 1 1 0 1 1 0 1 0 1 0 1];
A2 = H2(:,5:15);
G2 = [transpose(A2) eye(11)];

p = [10^-3:10^-3:9*10^-3 10^-2:10^-2:9*10^-2 10^-1:10^-1:5*10^-1];
P_u2 = zeros(1,length(p));
P_dc2 = zeros(1,length(p));
P_du2 = zeros(1,length(p));
P_e2 = zeros(1,length(p));

for i=1:length(p)
    transmitted2 = generating_codewords(rand_num2, G2); % original signal
    received2 = bin_sym_chan(transmitted2,p(i)); % signal with channel noise
    estimated2 = correcting(H2,received2); % estimated signal
    [P_u2(i), P_dc2(i), P_du2(i)] = Rates(transmitted2, received2, estimated2, H2);
    P_e2(i) = 1 - ( (1-p(i))^15+15*(1-p(i))^14*p(i) ) ;
end

P_t2 = P_u2 + P_du2;

% plot

figure(3); 
subplot(2,2,1);
loglog(p, P_u2);
grid on
title('P_u of (15,11,3)');
xlabel('p')
ylabel('P_u')

subplot(2,2,2);
loglog(p, P_dc2);
grid on
title('P_d_c of (15,11,3)');
xlabel('p')
ylabel('P_d_c')

subplot(2,2,3);
loglog(p, P_du2);
grid on
title('P_d_u of (15,11,3)');
xlabel('p')
ylabel('P_d_u')

subplot(2,2,4);
loglog(p, P_u2 + P_du2);
grid on
title('P_t of (15,11,3)');
xlabel('p')
ylabel('P_t')

figure(4)
plot(p,P_u2 + P_du2 - P_e2);
grid on
title('P_t - P_e of (15,11,3)')
xlabel('p')
ylabel('P_t - P_e')

figure(5)
loglog(p, P_u);
hold on
loglog(p, P_u2);
grid on
title('P_u of (7,4,3) vs (15,11,3)');
xlabel('p');
ylabel('P_u');
legend('P_u1', 'P_u2');

figure(6)
loglog(p, P_dc);
hold on
loglog(p, P_dc2);
grid on
title('P_d_u of (7,4,3) vs (15,11,3)');
xlabel('p');
ylabel('P_d_c');
legend('P_d_c1', 'P_d_c2');

figure(7)
loglog(p, P_du);
hold on
loglog(p, P_du2);
grid on
title('P_d_u of (7,4,3) vs (15,11,3)');
xlabel('p');
ylabel('P_d_u');
legend('P_d_u1', 'P_d_u2');

figure(8)
loglog(p, P_t);
hold on
loglog(p, P_t2);
grid on
title('P_t of (7,4,3) vs (15,11,3)');
xlabel('p');
ylabel('P_t');
legend('P_t1', 'P_t2');


%% functions

function output = bin_sym_chan(input,p) % passing binary symmetry channel
    output = zeros(size(input)); 
    [row, col] = size(input);
    for i=1:row
        for j=1:col
            r = randsample([0,1],1,true,[1-p,p]);
            if r == 1
                if input(i,j) == 1
                    output(i,j) = 0;
                else 
                    output(i,j) = 1;
                end
            else 
                output(i,j) = input(i,j);
            end
        end
    
    end
end

function codewords = generating_codewords(rand_num, G)
    codewords = zeros(10000,length(G(1,:)));
    for i=1:10000
        m = rand_num(i,:)*G;
        for j=1:length(m)
            m(j)=mod(m(j),2);
        end
    codewords(i,:) = m; % original signal
    %codewords1_binsym(i,:) = bin_sym_chan(m,p); % signal with channel noise
    end

end

function estimated_codewords = correcting(H,received) % estimating the received code
    estimated_codewords = zeros(size(received));
    H_rt = H*transpose(received);
    [row, col] = size(H_rt);
    for i=1:row
        for j=1:col
            H_rt(i,j) = mod(H_rt(i,j),2);
        end
    end
    for i=1:col
       if isequal(H_rt(:,i), zeros(size(H_rt(:,i))));
           estimated_codewords(i,:) = received(i,:);
       else
           for j=1:length(H(1,:))
               if isequal(H_rt(:,i), H(:,j))
                   estimated_codewords(i,:) = received(i,:);
                   if estimated_codewords(i,j) == 0
                       estimated_codewords(i,j) = 1;
                   else
                       estimated_codewords(i,j) = 0;
                   end
               end
           end
       end
    end
end

function H_rt = H_RT(received, H) % H*received^T
    H_rt = H*transpose(received);
    [row, col] = size(H_rt);
    for i=1:row
        for j=1:col
            H_rt(i,j) = mod(H_rt(i,j),2);
        end
    end
end

function [P_u, P_dc, P_du] = Rates(input, received, estimated, H) % Obtaning those rates
    n1 = 0;
    n2 = 0;
    n3 = 0;
    
    H_rt = H_RT(received, H);
    [row, col] = size(H_rt);

    for i=1:col
        if isequal(H_rt(:,i), zeros(row,1)) && ~isequal(input(i,:), received(i,:)) % if Hr = 0 and r ~= c
            n1 = n1+1;
        end
        if ~isequal(H_rt(:,i), zeros(row,1)) && isequal(input(i,:), estimated(i,:)) % if Hr = 0 and r ~= c
            n2 = n2+1;
        end
        if ~isequal(H_rt(:,i), zeros(row,1)) && ~isequal(input(i,:), estimated(i,:)) % if Hr = 0 and r ~= c
            n3 = n3+1;
        end
    end
    
    P_u = n1/10000;
    P_dc = n2/10000;
    P_du = n3/10000;
end
