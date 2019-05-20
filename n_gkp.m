function n = n_gkp(log_dim, phys_dim, d, tol)
%N_GKP returns the average photon number in a GKP code with given
%parameters, so that we can plot/optimise.

code = gkp_code(log_dim, phys_dim, d, tol);
n = trace(code' * num(phys_dim) * code) / log_dim;

end % function