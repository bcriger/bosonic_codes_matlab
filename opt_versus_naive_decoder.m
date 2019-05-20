% This script makes a bunch of fidelities 
clear all;
acc = 1e-7;
gmas = linspace(0.001, 0.999, 250);

for log_dim = 2:10
    disp(log_dim)
    load(strcat("num_code_", string(log_dim), ".mat"));
    bare_fids = single_rail_loss_f_e(log_dim, gmas);
    naive_fids = loss_f_e(gmas, code);
    opt_fids = loss_opt_f_e(gmas, code);
    
    n_bar = sqrt(2) * log_dim;
    katt = fourier_cat_code(log_dim, n_bar, acc);
    % naive decoder not CPTP, since KL criteria are not satisfied
    % cat_naive_fids = loss_f_e(gmas, katt); 
    cat_opt_fids = loss_opt_f_e(gmas, katt);

    binn = binomial_code(log_dim, 1, 0, 0);
    bin_naive_fids = loss_f_e(gmas, binn);
    bin_opt_fids = loss_opt_f_e(gmas, binn);
    save(char(strcat("fids_", string(log_dim),  ".mat")), 'gmas', 'bare_fids', 'naive_fids', 'opt_fids', 'cat_naive_fids', 'cat_opt_fids', 'bin_naive_fids', 'bin_opt_fids');
    % disp(size(code))
end % for