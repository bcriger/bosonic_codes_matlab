function ent_fids = sized_cat_loss_opt_f_e(log_dim, n_gmas, test_gmas, n_stars, acc)
%SIZED_CAT_LOSS_OPT_F_E returns an array of entanglement fidelities.
%In order to calculate these fidelities, we first figure out the
%optimal photon number for the cat code to have. This is done by
%interpolation, using the variables test_gmas and n_stars. 

gmas = linspace(test_gmas(1), test_gmas(end), n_gmas);
n_interp = interp1(test_gmas, n_stars, gmas, 'linear');

ent_fids = zeros(n_gmas);
for g_dx = 1:n_gmas
	sized_cat_code = fourier_cat_code(log_dim, n_interp(g_dx), acc);
	fid_list = loss_opt_f_e([gmas(g_dx)], sized_cat_code);
	ent_fids(g_dx) = fid_list(1);
end % for

end % function