function num = poly_coeff(n, m, d)
%Produces generalised binomial or "polynomial" coefficients, in line
%with equation C2 of 1602.00008v3
poly_arr = ones(1, d);
long_coeffs = poly_arr;

for conv_dx = 2:n
long_coeffs = conv(long_coeffs, poly_arr);
end % for

num = long_coeffs(end - m);

end % function