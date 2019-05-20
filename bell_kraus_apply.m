function new_state = bell_kraus_apply(map, old_state, bell_dim)
%BELL_KRAUS_APPLY applies a Kraus map to the first half of a register.
%You have to supply the dimension of the other half, since there might
%be an encoding.

size_map = size(map);
id = eye(bell_dim);

new_state = zeros(size_map(1) * bell_dim);

for map_dx = 1 : size_map(3)
    op = kron(map(:, :, map_dx), id);
    new_state = new_state + op * old_state * op';
end % for

end % function