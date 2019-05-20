function state = bell_state(dim)
%BELL_STATE returns a bell state over 2 dimension-dim systems
%
entry = 1. / sqrt(dim);
% state = zeros(dim^2, 1);
state = sparse(dim^2, 1);
state(1 : dim + 1 : dim^2) = entry;
end

