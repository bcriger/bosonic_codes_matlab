function big_map = loss_map(dim, gma)
%LOSS_MAP returns an error map with loss operators at all possible
%orders, given the dimension of the system being used.
%The data structure is a cell array populated with sparse matrices.

% big_map = sparse(dim, dim, dim);
% big_map = mat2cell(big_map, [dim], [dim], ones(1,dim));

a = a_op(dim);

%This only works because the number operator is diagonal:
% post_mat = diag(sqrt(1. - gma).^(diag(num(dim)))); 
n = num(dim);

post_mat = sparse(dim, dim);
for idx = 1 : dim
	post_mat(idx, idx) = sqrt(1. - gma)^n(idx, idx);
end % for

pre_factor = sqrt(gma / (1. - gma));
mid_mat = speye(dim);

% big_map(:, :, 1) = post_mat;
big_map{:, :, 1} = post_mat;
for a_dx = 1:dim-1
    mid_mat = mid_mat * a * pre_factor / sqrt(a_dx);
    % big_map(:, :, a_dx + 1) = mid_mat * post_mat;
    big_map{:, :, a_dx + 1} = mid_mat * post_mat;
end % for

end % function