function c = get_c_from_contractive_map_3b( K, Y, init_c, num_iter )
% now do the iteration to find c's
%T(c) = c - (1/n)*(Kc - Y)
    c = init_c;
    n = length(Y);
    for i=1:num_iter
        c = c - (1/n) * (K*c - Y);
    end
end

