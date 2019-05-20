function p_mat = p_op(dim)
a = a_op(dim);
p_mat = -i * (a - a') / sqrt(2);
end