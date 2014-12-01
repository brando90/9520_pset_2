function average_error = get_average_test_error(c, X_train, X_test, Y_test , sigma_train)
%get avg error for input c
%we have, f(x) = \sum_{i=1}^n (c_i*K(x, x_i)) = c \dot K(x,:)
    m = length(Y_test);
    error = zeros(m,1);
    %for each test point predict its label and evaluate error
    for i=1:m
        %get current test data to evaluate
        x_test = X_test(i);
        
        %Predict label with: f(x) = \sum_{i=1}^n (c_i*K(x, x_i))
        %f(c, x_test, X_train, sigma_train)
        y_test_label = f(c, x_test, X_train, sigma_train);
        
        %get error:
        e = abs(y_test_label - Y_test(i));
        error(i) = e;
    end

    average_error = mean(error);
end