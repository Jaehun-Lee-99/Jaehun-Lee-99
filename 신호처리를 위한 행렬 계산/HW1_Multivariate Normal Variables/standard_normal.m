% 20180490 Jaehun Lee - Programming assignment 1
function [y] = standard_normal(size)
    % [parameters]
    % size: array
    %   shape of generated samples
    % [returns]
    % y: array
    %   samples drawn from the standard normal distribution
    %
    
    % Generate samples using the Central Limit Theorem (CLT)
    % According to CLT, for i.i.d. random samples from the distribution, 
    % the standardized sample mean's distribution tends to follow the standard normal distribution
        
    % First, we generate samples (S) of size N x Size from the uniform distribution
    % (use MATLAB's 'rand' function which returns samples from Unif(0,1))
    N = 1000;
    
    %%%%%%% [Write down your code in the following block]
    S = rand([size, N]);
    %%%%%%%
        
    % Second, return the mean along the first dimension (N) of sample S
    % (Hint: Use 'sum' or 'mean' function)
    
    %%%%%%% [Write down your code in the following block]
    S_mean = mean(S, 3);
    %%%%%%%
    
    % Now, standardize each sample mean.
    % If 'mu' refers to the mean and 'sigma' refers to the standard deviation of the
    % distribution, we can standardize it as follows:
    % y = (S_mean - mu) / (sigma / sqrt(N))
    
    %%%%%%% [Write down your code in the following block]
    mu = (0+1)/2;
    sigma = sqrt((1^2 - 0^2)/12);
    y = (S_mean - mu) / (sigma / sqrt(N));
    %%%%%%%
    
    % Reshape the output as input shape, 'size'
    y = reshape(y, size);
end


