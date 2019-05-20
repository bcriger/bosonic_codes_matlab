function q_mat = q_op(dim)
a = a_op(dim);
q_mat = (a + a') / sqrt(2);
end