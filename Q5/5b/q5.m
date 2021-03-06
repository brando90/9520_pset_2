load('ps2-dataset.mat');

n_vector = [4 8 16 32 64];
%n_vector = 4:64;

% ith entry corresponds to mean accuracy after sampling 10 random data set
% of size n = n_vector(n_i) from labeled data (using tikhonov).
accuracy_laplacian_for_N_mean = zeros(size(n_vector));
% ith entry corresponds to std accuracy after sampling 10 random data set
% of size n = n_vector(n_i) from labeled data (using tikhonov).
accuracy_laplacian_for_N_std = zeros(size(n_vector));
for ni = 1:length(n_vector);
    accuracy_laplacian_rand_samples = zeros(1, 10);
    %evaluate 10 random samples from labeled for the current length n.
    n = n_vector(ni); %sample n from labeled set to train our Algs
    for s = 1:10;
        nl = length(yl);
        
        n_rand_rows =  randsample(nl, n) ;    % random numbers to select rows.
        Xl_rand_s = Xl(n_rand_rows, : ); %10 random rows
        yl_rand_s = yl(n_rand_rows); %10 random labels

        %classify Laplacian (in another function, takes W, returns accu)
        result = get_accuracy_from_Laplacian(Xl_rand_s, Xu, yl_rand_s, yu);
        yp = result(1);
        acc = result(2);
        accuracy_laplacian_rand_samples(s) = get_accuracy_from_Laplacian(Xl_rand_s, Xu, yl_rand_s, yu);
    end
    accuracy_laplacian_for_N_mean(ni) = mean(accuracy_laplacian_rand_samples);
    accuracy_laplacian_for_N_std(ni) = std(accuracy_laplacian_rand_samples);
end

display([accuracy_laplacian_for_N_mean; accuracy_laplacian_for_N_std], 'accuracy_laplacian_for_N');

figure
errorbar(n_vector, accuracy_laplacian_for_N_mean, accuracy_laplacian_for_N_std, 'green');
title('ComparisonLaplacian vs. Tikhonov');
ylabel('Avg. accuracy on unlabeled data')
xlabel('Number of labeled examples')
ylim([0 1.05]);



