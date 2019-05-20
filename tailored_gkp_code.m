function u_gkp = tailored_gkp_code(log_dim, n_bar, gkp_tol, orth_tol)
%TAILORED_GKP_CODE sets the required physical dimension and squeezing
%parameter for a GKP code in terms of the desired average photon number.
%There's an approximation for delta in terms of the average photon 
%number (from eq. 7.10 in "Performance & Structure"):
%              Delta \sim \sqrt(1./(2 * (n_bar + 0.5)))
%I'm going to use that as an initial guess, which I refine by bisection
%search, same as for cat codes. 
%For the physical dimension, I iterate, starting from 3 * n_bar / sqrt(2)
%which is the required physical dimension for compressed codes, then
%increment until the average abs_off_diag between states in the same code
% is less than `tol`. 

abs_off_diag = 0.5;

phys_dim = ceil(3 * n_bar / sqrt(2)); % almost certainly not big enough
code = gkp_code(log_dim, phys_dim, 1, 1e-4); % not actually used for anything
while abs_off_diag > orth_tol
	phys_dim = phys_dim + 1;
	old_code = code;
	delta = fsolve(@(d) n_gkp(log_dim, phys_dim, d, gkp_tol) - n_bar, sqrt(1. / (2 * n_bar + 1)));
	code = gkp_code(log_dim, phys_dim, delta, gkp_tol);
	orth_mat = abs(code' * code - speye(log_dim));
	abs_off_diag = max(max(orth_mat));
	disp(phys_dim) % DEBUG
	disp(abs_off_diag) % DEBUG
end % while

u_gkp = code;

end % function