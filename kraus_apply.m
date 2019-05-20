function lambda_rho = kraus_apply(kraus_map, density_matrix)
%kraus_apply basically returns sum(a_j * rho * a_j')

%no tuples
size_map = size(kraus_map);
out_dim = size_map(1);
num_ops = size_map(3);

%no list comprehensions
lambda_rho = zeros(out_dim, out_dim);
for map_dx = 1:num_ops
    % lambda_rho = lambda_rho + kraus_map(:, :, map_dx) * density_matrix * kraus_map(:, :, map_dx)';
    lambda_rho = lambda_rho + kraus_map{:, :, map_dx} * density_matrix * kraus_map{:, :, map_dx}';
end % for

end % function