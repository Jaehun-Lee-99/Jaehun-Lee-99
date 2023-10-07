% DO NOT MODIFY THIS FILE

rng(1234);

A = rand(6, 6);
b = rand(6, 1);

cond_num(A, 2)

GT_x = inv(A) * b;

x = zeros(100, 5);
idx = 0;
A_cond = zeros(5);
for lambda = 0.0:0.1:0.4
    idx = idx + 1;
    for i = 1:100
        b_e = b + reshape(mvnrnd(0, 1, prod(size(b))), size(b));
        A_pinv_reg = inv(A' * A + lambda * eye(length(A))) * A';
        x_i = A_pinv_reg * b_e;
        x(i, idx) = norm_ord(GT_x - x_i, 2);  
    end
    cond_num(A_pinv_reg, 2)
    
    
end

boxplot(x, 'Labels',{0.0, 0.1, 0.2, 0.3, 0.4})
xlabel('$\lambda$', Interpreter="latex")
ylabel('$||x-\hat{x}||_2$', Interpreter="latex")
title('Compare sensitivity of linear system')