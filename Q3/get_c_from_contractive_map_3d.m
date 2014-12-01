function c = get_c_from_contractive_map_3d( K, Y, init_c, num_iter, lambda )
% T(c) = c - (1/(n+lambda)) * ((K+lambda*I)*c - Y);
    c = init_c;
    n = length(Y);
    I = eye(n);
    for i=1:num_iter
        c = c - (1/(n+lambda)) * ((K+lambda*I)*c - Y);
    end
end



