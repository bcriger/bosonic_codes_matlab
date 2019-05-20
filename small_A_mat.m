function mat_out = small_A_mat(phys_dim, log_dim)
%Produces an A matrix for the SDP describing an optimal decoding isometry

% iden = sparse(complex(eye(phys_dim)));
% iden = complex(eye(phys_dim));
iden = speye(phys_dim);

mat_out = sparse(phys_dim^2, phys_dim^2 * log_dim^2);
% mat_out = zeros(phys_dim^2, phys_dim^2 * log_dim^2);
    
for k = 1:log_dim
    k_vec = sparse(1, log_dim);
    % k_vec = zeros(1, log_dim);
    k_vec(k) = 1 + 0i;
    tmp_mat = kron(k_vec, iden); %check order often
    mat_out = mat_out + kron(tmp_mat, tmp_mat);
end % for

% mat_out = sparse(complex(mat_out));

end % function