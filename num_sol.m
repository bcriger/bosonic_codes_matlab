function new_vec = num_sol(dim, jay, n_bar, param_vec)
%NUM_SOL produces a set of angles (theta and phi) which define a state
% orthogonal to the one defined by param_vec under a loss operator,
% and has the same mean photon number n_bar.

c = param_vec; % not trying to mess with that big variable name
x0 = [pi/4; pi/4];
new_vec = fsolve(@(x) qudit_loss_obj_fun(x, dim, jay - 1, n_bar, c), x0);
end

function obj = qudit_loss_obj_fun(theta_phi, dim, jay, n_bar, c)

theta = theta_phi(1);
phi = theta_phi(2);

obj = [0; 0];
    
obj(1) = jay * cos(theta)^2 + (dim + jay + 1) * sin(theta)^2 * cos(phi)^2 + (2 * dim + jay + 2) * sin(theta)^2 * sin(phi)^2 - n_bar;
obj(2) = sqrt(jay + 1) * c(1) * cos(theta) + sqrt(dim + jay + 2) * c(2) * sin(theta) * cos(phi) + sqrt(2 * dim + jay + 3) * c(3) * sin(theta) * sin(phi);

end