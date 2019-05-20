function ent_fids = loss_f_e(gmas, u_enc)
%LOSS_F_E returns an array of entanglement fidelities which
%result from passing half a Bell state through a given encoder, 
%through a full photon-loss noise map, through the naive recovery map, 
%and back out through the unitary decoder, before taking the fidelity
%wrt an un-messed-with Bell state. 

%For the record, the single-rail fidelity is
% 0.25 * (2 - gamma + 2 * sqrt(1 - gamma))

[phys_dim, log_dim] = size(u_enc);

omega = bell_state(log_dim);
bell_proj = bell_mat(log_dim);

% u_enc = three_term_code(log_dim);
code_proj = u_enc * u_enc';

% single loss only
corr_errs = zeros(phys_dim, phys_dim, 2);
corr_errs(:, :, 1) = eye(phys_dim);
corr_errs(:, :, 2) = a_op(phys_dim);

rec_map = naive_recovery_map(code_proj, corr_errs);

enc_state = kron(u_enc, eye(log_dim)) * bell_proj * kron(u_enc, eye(log_dim))';

size_gmas = size(gmas);
n_gmas = max(size_gmas);
ent_fids = zeros(size_gmas);
for g_dx = 1:n_gmas
    noise_map = loss_map(phys_dim, gmas(g_dx));
    noisy_state = bell_kraus_apply(noise_map, enc_state, log_dim);
    recovered_state = bell_kraus_apply(rec_map, noisy_state, log_dim);
    dec_state = kron(u_enc, eye(log_dim))' * recovered_state * kron(u_enc, eye(log_dim));
    ent_fids(g_dx) = omega' * dec_state * omega; 
end % for

end % function