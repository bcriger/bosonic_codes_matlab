function loss_mat = a_op(dim)
%A_OP returns a loss operator in the Fock space of a QHO. 
%I'm going to try to do everything sparsely, but I'll leave
%full matrices commented out. 

% loss_mat = diag(sqrt([1 : dim - 1]), 1);

%I don't know how to use spdiags
loss_mat = sparse(dim, dim);
for dx = 1 : dim - 1
	loss_mat(dx, dx + 1) = sqrt(dx);
end % for

end % function