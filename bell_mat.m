function mat = bell_mat(dim)
%BELL_MAT returns a bell projector over 2 dimension-dim systems
%
vec = bell_state(dim);
mat = vec * vec';
end

