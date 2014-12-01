function accuracy = get_accuracy_from_Tikhonov_RLS_Gaussian(X_l, X_u, y_l, y_u)
% trains the predictor with the labeled and unlabed data that it gets.
% it returns the accuracy of the trained predictor based on the unlabeled
% labels. Notice that the labels coming from the unlabeled set are only
% used for accuracy, not during the training nor prediction (these are
% suppose to be unknown!).
addpath(genpath('/Users/brandomiranda/Documents/MIT/2014/Fall_2014/9.520/9520_fall2014_pset2/9.520_Pset_template/GURLS'));
name = 'Tikhonov_settings_&_results';
opt = defopt(name);
opt.seq = {'paramsel:siglam', 'kernel:rbf', 'rls:dual', ...
'predkernel:traintest', 'pred:dual', 'perf:macroavg'};
opt.process{1} = [2,2,2,0,0,0];
opt.process{2} = [3,3,3,2,2,2];
gurls(X_l, y_l, opt, 1);
gurls(X_u, y_u, opt, 2);
accuracy = opt.perf.acc;
end