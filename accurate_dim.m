function min_phys_dim = accurate_dim(alfa, acc)
%ACCURATE_DIM answers the age-old question: how large does the physical
%dimension of a simulated quantum harmonic oscillator have to be before
%it can accurately contain a coherent state of amplitude alfa?
min_phys_dim = 1;
state_vec = coherent_state(min_phys_dim, alfa);
while abs(norm(state_vec)-1) > acc
    min_phys_dim = min_phys_dim + 1;
    state_vec = coherent_state(min_phys_dim, alfa);
end % if
end % function