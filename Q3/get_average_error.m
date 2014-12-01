function average_error = get_average_error( c, K, Y )
%getfind avg error for input c
%we have, f(x) = \sum_{i=1}^n (c_i*K(x, x_i)) = c \dot K(x,:)
    n = length(Y);
    error = zeros(n,1);
    for i=1:n
        K_x_xi = K(i,:);
        f_x = dot(K_x_xi, c);
        e = abs(f_x - Y(i));
        error(i) = e;
    end

    average_error = mean(error);
end