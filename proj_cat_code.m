function code_coeffs = proj_cat_code(log_dim, n_bar, acc)
%PROJ_CAT_CODE outputs a unitary encoder (a matrix with the codewords
%as columns) for a cat code like in Equations 8 & 9 of
%https://arxiv.org/pdf/1503.00194.pdf

%alpha is a special name in matlab
%also this alfa is basically sqrt(n), but imprecision is haram.
alfa = fsolve(@(a) n_cat_code(a) - n_bar, sqrt(n_bar));
phys_dim = accurate_dim(alfa, acc);
vec = coherent_state(phys_dim, alfa);

for log_dx = 0 : log_dim - 1
    for proj_dx = log_dx : log_dim : phys_dim - 1
        code_coeffs(proj_dx + 1, log_dx + 1) = vec(proj_dx + 1);
    end % for
    code_coeffs(:, log_dx + 1) = code_coeffs(:, log_dx + 1) / norm(code_coeffs(:, log_dx + 1));
end % for

end % function