function small_mat = sparse_clean(big_mat, tol)
%SPARSE_CLEAN eliminates all elements of a sparse matrix that are less
%than tol in absolute value.
[r, c, v] = find(big_mat);
big_dxs = find(abs(v) > tol);
[rs, cs] = size(big_mat);
small_mat = sparse(r(big_dxs), c(big_dxs), v(big_dxs), rs, cs);
end % function