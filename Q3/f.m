function [ y_test_label ] = f(c, x_test, X_train, sigma_train)
% Predicts label of x_test based on the training data and c
% f(x) = \sum_{i=1}^n (c_i*K(x, x_i)) = c \dot K(x,:)
n = length(X_train);
fx = 0;
for i=1:n
    x_train = X_train(i);
    c_i = c(i);
    % exp( -||x - x'||^2 / 2 sigma^2)
    dist = norm(x_test - x_train, 2);
    Kxxi = exp(- 0.5 * (dist^2) * (1/sigma_train^2));
    fx = fx + c_i * Kxxi;
end

y_test_label = fx;
end

