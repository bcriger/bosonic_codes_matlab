function num_mat = num(dim)

% num_mat = diag([0 : dim - 1]);
num_mat = sparse(1 : dim, 1 : dim, 0 : dim - 1);
end