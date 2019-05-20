function u_gkp = gkp_code(log_dim, phys_dim, delta, tol)
%GKP_CODE returns an encoder into the Z-bar basis of a finite-squeezing
%GKP code, using a zesty mix of equations 26-27 from GKP and equation
%7.7a from "Performance and Structure of Single-Mode Bosonic Codes".

u_gkp = zeros(phys_dim, log_dim);

sq = squeeze(-log(delta), phys_dim, tol);
sq_0 = sq(:, 1);

for col = 1 : log_dim
	u_gkp(:, col) = gkp_state(log_dim, phys_dim, delta, tol, col, sq_0);
end % for

u_gkp = sparse_clean(u_gkp, tol);

end % function

function log_state = gkp_state(log_dim, phys_dim, delta, tol, idx, sq_0)
	
	%very important off-by-one prevention
	dx = idx - 1;
	% disp(dx) % DEBUG

	% pre-computation
	d_2 = delta^2;
	pi_d = pi / log_dim;
	sq_pi_d = sqrt(pi_d);

	log_state = zeros(phys_dim, 1);
	
	% middle-out construction for the logical state
	n = 0;
	% start with middle peak
	updated_log_state = exp(- pi_d * d_2 * dx^2) * displace(sq_pi_d * dx, phys_dim, tol) * sq_0;
	while abs(norm(updated_log_state - log_state)) > tol
		% disp(abs(norm(updated_log_state - log_state))) % DEBUG
		log_state = updated_log_state;
		n = n + 1;

		% if the state hasn't converged, add two more peaks

		pos_dx = log_dim * n  + dx;
		neg_dx = -log_dim * n  + dx;

		upd8 = exp(-pi_d * d_2 * pos_dx^2) * displace(sq_pi_d * pos_dx, phys_dim, tol) * sq_0;
		upd8 = upd8 + exp(-pi_d * d_2 * neg_dx^2) * displace(sq_pi_d * neg_dx, phys_dim, tol) * sq_0;

		updated_log_state = log_state + upd8;
	end % while

	log_state = updated_log_state / norm(updated_log_state);

end % function

function UNUSED = UNUSED(log_dim, phys_dim, omega, tol)
%GKP_CODE returns the lowest `log_dim` states of a Hamiltonian from
%gkp_ham.

h_gkp = gkp_ham(log_dim, phys_dim, omega, tol);
[u_gkp, vals] = eigs(h_gkp, log_dim, 'smallestreal');
u_gkp = sparse_clean(u_gkp, tol);

end % function