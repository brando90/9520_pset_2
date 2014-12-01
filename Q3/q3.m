load(fullfile('ps1-dataset.mat'));

%calculates average distance between points
sigma_train = mean(pdist(Xtrain));
sigma_test = mean(pdist(Xtest));
%compute kernel matrices for both test and train data
K_train = rbf(Xtrain, sigma_train); 
%K_test = rbf(Xtest, sigma_test);

[n_train, D] = size(Xtrain);

%plot error vs. iteration for 3b)
maximum_num_itera = 25;
step = 1;
iteration_vector = 1:step:maximum_num_itera;
train_error_vector = zeros(1, length(iteration_vector));
test_error_vector = zeros(1, length(iteration_vector));

c = zeros(n_train,1);

for i = 1:length(iteration_vector)
    %number of iterations to run the current contractive map
    current_iter = iteration_vector(i);
    %get c vector from training data
    c = get_c_from_contractive_map_3b(K_train, Ytrain, c, current_iter);
    
    % Get test and train errors
    avg_train_error = get_average_error(c, K_train, Ytrain);
    %get_average_test_error(c, X_train, X_test, Y_test , sigma_train)
    avg_test_error = get_average_test_error(c, Xtrain, Xtest, Ytest , sigma_train);
    
    train_error_vector(i) = avg_train_error;
    test_error_vector(i) = avg_test_error;
end

% figure();
% plot(iteration_vector, train_error_vector, iteration_vector, test_error_vector);
% xlabel('iterations');
% ylabel('error');


% plots for the 3 d part
lambda = 6;
c = zeros(n_train,1);
for i = 1:length(iteration_vector)
    %number of iterations to run the current contractive map
    current_iter = iteration_vector(i);
    %get c vector from training data
    c = get_c_from_contractive_map_3d(K_train, Ytrain, c, current_iter, lambda);
    
    % Get test and train errors
    avg_train_error = get_average_error(c, K_train, Ytrain);
    avg_test_error = get_average_test_error(c, Xtrain, Xtest, Ytest, sigma_train);
    
    train_error_vector(i) = avg_train_error;
    test_error_vector(i) = avg_test_error;
end


figure();
plot(iteration_vector, train_error_vector, iteration_vector, test_error_vector);
title('lambda = 6')
xlabel('iterations');
ylabel('error');

%plot(iteration_vector, test_error_vector);

%plot relation between lambda and iteration


