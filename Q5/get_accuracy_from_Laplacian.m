function res = get_accuracy_fromLaplacian(Xl, Xu, yl, yu)

Xt = [Xl; Xu];

%% Parameters                 
sig = .010;

%% adjacency matrix W
m = length(Xt);
W = zeros(m, m);
for i = 1:m
   for j = 1:m
      distance = norm(Xt(i,:)-Xt(j,:), 2);
      %d = ( (Xt(r,1)-Xt(c,1))^2 + (Xt(r,2)-Xt(c,2))^2 ) ^1/2; % euclidean distance
      current_similarity_weight = exp( (- 1/sig^2) * distance^2);
      W(i,j) = current_similarity_weight;
   end
end

%% Laplacian matrix
D = zeros(size(W));
for i = 1:length(W(:,1))
   D(i,i) = sum(W(i,:)); 
end
%make L matrix from part 2b)
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
yu_temp = - 1/2 * Luu \ (Lul + Llu.') * yl;

yu_class = ones(u,1);
yu_class(yu_temp <= 0) = -1;      % classify -1 if yu<=0 and 1 otherwise
accu = sum((yu_class == yu)) /u; 
res = accu;
end