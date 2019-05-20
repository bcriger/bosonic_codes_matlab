function ent_fids = single_rail_loss_f_e(dim, gmas)
%SINGLE_RAIL_LOSS_F_E returns an array of entanglement fidelities which
%result from passing half a Bell state through a full photon-loss noise
%map alone, before taking the fidelity wrt an un-messed-with Bell
%state. 

omega = bell_state(dim);
bell_proj = omega * omega';

size_gmas = size(gmas);
n_gmas = max(size_gmas);
ent_fids = zeros(size_gmas);
for g_dx = 1:n_gmas
    noise_map = loss_map(dim, gmas(g_dx));
    noisy_state = bell_kraus_apply(noise_map, bell_proj, dim);
    ent_fids(g_dx) = omega' * noisy_state * omega; 
end % for

end % function