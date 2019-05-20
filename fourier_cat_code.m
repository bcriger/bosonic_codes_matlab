function code_coeffs = fourier_cat_code(log_dim, n_bar, acc)
%FOURIER_CAT_CODE outputs a unitary encoder (a matrix with the codewords
%as columns) for a cat code like in Equation 25 of
%https://arxiv.org/pdf/1605.00357.pdf, but inverse-QFT'd.

%alpha is a special name in matlab
%also this alfa is basically sqrt(n), but imprecision is haram.
alfa = fsolve(@(a) n_cat_code(a) - n_bar, sqrt(n_bar));
%phys_dim dictates matrix size, I must ensure minimum number of states
phys_dim = max(accurate_dim(alfa, acc), 2 * log_dim);

%prefactor = exp(-abs(alfa)^2 / 2.) * sqrt(log_dim) / sqrt(1. + exp(-2. * abs(alfa)^2));

for phys_dx = 0 : 2 : phys_dim - 1
    log_dx = mod(phys_dx / 2, log_dim); 
    code_coeffs(phys_dx + 1, log_dx + 1) = (alfa^phys_dx) / sqrt(factorial(phys_dx));
end % for

% normalise those columns
for log_dx = 1 : log_dim
    nrm = norm(code_coeffs(:, log_dx));
    code_coeffs(:, log_dx) = code_coeffs(:, log_dx) / nrm;
end % for

end % function