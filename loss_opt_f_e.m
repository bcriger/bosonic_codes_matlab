function ent_fids = loss_opt_f_e(gmas, u_enc, method)
%LOSS_OPT_F_E returns an array of entanglement fidelities which
%result from passing half a Bell state through a given encoder, 
%through a full photon-loss noise map, through an SDP-optimised
%recovery map, and back out through the unitary decoder, before
%taking the fidelity wrt an un-messed-with Bell state. 

%This function uses a different method for calculating fidelities
%, based on an SDP 

[phys_dim, log_dim] = size(u_enc);

% disp([phys_dim, log_dim])

A = small_A_mat(phys_dim, log_dim);
b = small_b_vec(phys_dim, log_dim);

K.f = 0;
K.l = 0;
K.q = 0;
K.r = 0;
K.s = [phys_dim * log_dim];

size_gmas = size(gmas);
n_gmas = max(size_gmas);
ent_fids = -ones(size_gmas);

% Don't trust any of this, I'm just trying to get csdp to work. 
if method == "csdp"
    A = real(A);
    b = real(b);
    pars.printlevel = 0;
    pars.fastmode = 0;

    noise_map = loss_map(phys_dim, gmas(1));
    c = real(small_c_vec(u_enc, noise_map));
    [x, y, z, innfo] = csdp(A, b, c, K, pars);
    % x0 = x; y0 = y; z0 = z;

    ent_fids(1) = -c' * x; 
    first_in_loop = 2;
elseif method == "sedumi"
    % From sedumi.m:
    % If alg=1, then SeDuMi uses
    % the centering-predictor-corrector algorithm with v-linearization.
    pars.alg = 1;
    first_in_loop = 1;
    K.scomplex = 1;
    pars.fid = 0;
else
    error('method must == "csdp" or "sedumi"');
end % if

parfor g_dx = first_in_loop : n_gmas
    noise_map = loss_map(phys_dim, gmas(g_dx));
    c = small_c_vec(u_enc, noise_map);
    if method == "csdp"
        c = real(c);
        % [x, y, z, innfo] = csdp(A, b, c, K, pars, x0, y0, z0);
        [x, y, z, innfo] = csdp(A, b, c, K, pars);
        % x0 = x; y0 = y; z0 = z;
    else
        [x, y, innfo] = sedumi(A, b, c, K, pars);
    end % if

    ent_fids(g_dx) = -c' * x; 
end % for

end % function