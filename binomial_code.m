function code_coeffs = binomial_code(dim, l, g, d)
%BINOMIAL_CODE outputs a unitary encoder (a matrix with the codewords
%as columns) for a generalised binomial code like in equation C4 of 
%1602.00008v3. 
S = l + g;
N = max([l, g, 2 * d]);
phys_dim = (S + 1) * (dim - 1) * (N + 1) + 1;

code_coeffs = zeros(phys_dim, dim);

w = exp(2 * pi * j / dim);

for mu = 0 : dim - 1
    for p = 0 : (dim - 1) * (N + 1)
        num = w^(mu * p) / sqrt(dim^(N + 1)) * sqrt(poly_coeff(N + 1, p, dim));
        code_coeffs((S + 1) * p + 1, mu + 1) = num;
    end
end

end