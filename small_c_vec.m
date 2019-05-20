function vec_out = small_c_vec(u_enc, error_map)
%SMALL_C_VEC This is probably the most complicated part of the SDP.
%The c vector is the hermitian conjugate of the column-stack of the
%Choi state of the composition of encoding and
%transmission in that order.

size_err_map = size(error_map);
num_ops = size_err_map(3);

size_u_enc = size(u_enc);
phys_dim = size_u_enc(1);
log_dim = size_u_enc(2);

% composite_channel = zeros(phys_dim * log_dim, log_dim^2, num_ops);
% for err_dx = 1:num_ops
%     composite_channel(:,:,err_dx) = kron(eye(log_dim), conj(error_map(:,:,err_dx) * u_enc));
% end

for err_dx = 1:num_ops
    composite_channel{:,:,err_dx} = kron(speye(log_dim), conj(error_map{:,:,err_dx} * u_enc));
end

bell_proj = bell_mat(log_dim);

%I can prove that I need this scaling factor, it's not ad hoc.
ref_state = phys_dim / log_dim * kraus_apply(composite_channel, bell_proj);

vec_out = -sparse(complex(col_stack(ref_state)));

end