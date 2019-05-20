function [] = gkp_task(job_dx)
	% add SeDuMi to path, by any means necessary
	addpath(genpath('.'));

	% disp(job_dx)
	gmas = linspace(0.001, 0.8, 250);
	lil_gmas = gmas(job_dx : job_dx + 9);

	% basic setup
	phys_dim = 10;
	log_dim = 4;

	% average photon number from d = 4 compressed code
	n_bar = 4.424428894086496;

	% squeezing ensures approximate mean photon numbers are similar
	delta = sqrt(1. / (2. * (n_bar + 0.5)));
	
	tol = 1e-12;
	
	u_gkp = gkp_code(log_dim, phys_dim, delta, tol);
	
	lil_fids = loss_opt_f_e(lil_gmas, u_gkp, "sedumi"); 
	
	flnm = strcat("gkp_code_4_task_", string(job_dx), ".mat");
	save(flnm, "job_dx", "lil_gmas", "u_gkp", "lil_fids", "log_dim", "phys_dim", "delta", "tol");
end