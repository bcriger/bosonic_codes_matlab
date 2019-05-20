function vec_out = small_b_vec(phys_dim, log_dim)
%B_VEC RHS of the Ax = b constraint in the optimal-decoder SDP
% vec_out = sparse(complex(bell_state(phys_dim) / sqrt(phys_dim)));
vec_out = bell_state(phys_dim) / sqrt(phys_dim);
end