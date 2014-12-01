%   9.520 Statistical Learning Theory and Application
% Fall 2014
% Pset #2; Problem 5 (c)
% Reza Mohammadi Ghazi
% Doctoral Candidate, Department of Civil and Environmental Engineering

function [Yp , acc] = GURLfit(Xtr, Ytr, Xte, Yte)

name = 'part_a';
opt = defopt(name);
opt.seq = {'paramsel:siglam', 'kernel:rbf', 'rls:dual',...
    'predkernel:traintest', 'pred:dual','perf:macroavg'};
opt.process{1} = [2,2,2,0,0,0];
opt.process{2} = [3,3,3,2,2,2];
train = gurls (Xtr, Ytr, opt, 1);
test = gurls (Xte, Yte, opt, 2);

acc = test.perf.acc;
Yp = test.pred;

end

