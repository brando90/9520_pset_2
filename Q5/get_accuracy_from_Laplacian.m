function res = get_accuracy_fromLaplacian(Xl, Xu, yl, yu)

Xt = [Xl; Xu];

%% Parameters
epsilon = .005;                    
sig = .008;

%% adjacency matrix W
m = length(Xt);
W = zeros(m, m);
for i = 1:m
   for j = 1:m
      distance = norm(Xt(i,:)-Xt(j,:), 2);
      %d = ( (Xt(r,1)-Xt(c,1))^2 + (Xt(r,2)-Xt(c,2))^2 ) ^1/2; % euclidean distance
      current_similarity_weight = exp(- 1/sig^2 * distance^2);
      if current_similarity_weight <= epsilon
          W(i,j) = 0;
          %W(i,j) = exp(- 1/sig^2 * d^2);         % heat kernel weight
      else
          W(i,j) = current_similarity_weight;
      end
   end
end
%hist(W(W>0)); show distribution of weights

%% Laplacian matrix
for i = 1:length(W(:,1))
   D(i,i) = sum(W(i,:)); 
end
L = D - W;
l = length(Xl); 
u = length(Xu);
Lll = L(1:l, 1:l);
Llu = L(1:l, l+1:l+u);
Lul = L(l+1 : l+u, 1:l);
Luu = L(l+1 : l+u, l+1 : l+u);

%% Classify Xu
%change it by using pseudo inverse?
Luu = Luu + 0.0001*eye(size(Luu));
yu_ = - 1/2 * Luu \ (Lul + Llu.') * yl;

yu_class = ones(u,1);
yu_class(yu_ <= 0) = -1;      % classify -1 if yu<=0 and 1 otherwise
accu = sum((yu_class == yu)) /u;
%display([Xu(1:50, :), yu(1:50), yu_(1:50), yu_class(1:50)]);
%display(accu, 'accu');
%% 
res = accu;
% notes: 
%   (1) check why Luu is not invertible as is (line 50)
end