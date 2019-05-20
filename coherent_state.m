function state_vec = coherent_state(phys_dim, alfa)
%COHERENT_STATE outputs a coherent state as a column vector in the 
% Fock basis. 
state_vec = zeros(phys_dim, 1);
elem = 1;
for n_dx = 0:phys_dim-1
    state_vec(n_dx + 1) = alfa^n_dx / sqrt(factorial(n_dx));
    elem = elem * alfa / sqrt(n_dx + 1);
end % for

state_vec = state_vec * exp(-0.5 * abs(alfa)^2);

end % function