function big_vec = col_stack(lil_mat)
%col_stack Column stacks a matrix
big_vec = reshape(lil_mat, prod(size(lil_mat)), 1);
end