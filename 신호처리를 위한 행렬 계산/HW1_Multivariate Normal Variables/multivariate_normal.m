% 20180490 Jaehun Lee - Programming assignment 1
function [y] = multivariate_normal(mean, cov, size)
    % [parameters]
    % mean: mean of a multivaraite normal random vector (1 x X array)
    % cov: X x X array
    %   covariance matrix of a multivaraite normal random vector
    % size: array
    %   shape of the generated samples output (y). final output size will
    %   be X x size
    % [returns]
    % y: X x size array
    %   samples drawn from the multivariate normal distribution
    
    % check if the mean and covariance matrix have the same legnth
    if length(mean) == length(cov)
        ;
    else
        error('The mean and covariance should have the same length')
    end
        
    % check if the covariance matrix is symmetric positive semi-defininte
    if issymmetric(cov) &&  all(eig(cov) >= 0)
        ;
    else
        error('The covariance should be a symmetric positive semi-defininte matrix')
    end
        
    
    % (1) compute the size of the output and (2) create a matrix of the same size which is
    % independent and standard normal distributed using the provided 'standard_normal' function
    final_size = [size, length(mean)];
    x = standard_normal(final_size);
    x = reshape(x, [], length(mean));
    
    % The linear combination of multivariate normal random vectors is also
    % a multivariate normal distribution.
    % Therefore, given a multivariate normal random vector X with a mean of
    % 'mu' and covariance of 'sigma',
    % apply an arbitrary linear transform to X so that:
    % Y = A + X B
    % Then, the new multivariate normal random vector Y will have the mean
    % of 'A + mu B' and covariance of 'B^T sigma B'.
    
    % Calculate 'A' and 'B' so that the new multivariate normal random
    % vector y follows the input parameters 'mean' and 'cov'.
    % Since we haven't learned about the Cholesky Decomposition yet, we 
    % will provide 'B' that satisfies 'B^T B = cov'
    B = chol(cov);
    
    %%%%%%% [Write down your code in the following block] 
    A = mean;
    y = A + x*B;
    %%%%%%%
    
    % Reshape the output y to shape of 'final_size'
    y = reshape(y, final_size);
end