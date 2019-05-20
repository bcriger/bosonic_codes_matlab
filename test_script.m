% This script is intended to calculate a bunch of stuff twice to
% ensure that it comes out the same.
% You know how tests work.

%--------------------------------Setup--------------------------------%

log_dim = 4;
phys_dim = 3 * log_dim;
test_code = three_term_code(log_dim);

% Note: correctable errors need not be a CPTP channel
% this list of arrays is only used to derive the decoder,
% which is CPTP.
corr_errs = zeros(phys_dim, phys_dim, 2);
corr_errs(:, :, 1) = eye(phys_dim);
corr_errs(:, :, 2) = a_op(phys_dim);

code_proj = test_code * test_code';
naive_map = naive_recovery_map(code_proj, corr_errs);
disp('kraus_test(naive_map) - eye(phys_dim)')
disp(kraus_test(naive_map) - eye(phys_dim))

naive_isometry_map = zeros(log_dim, phys_dim, 3);
naive_isometry_map(:, :, 1) = test_code' * naive_map(:, :, 1);
naive_isometry_map(:, :, 2) = test_code' * naive_map(:, :, 2);
naive_isometry_map(:, :, 3) = test_code' * naive_map(:, :, 3);

disp('kraus_test(naive_isometry_map) - eye(phys_dim)')
disp(kraus_test(naive_isometry_map) - eye(phys_dim))

%-----------------------Channel Fidelity------------------------------%
