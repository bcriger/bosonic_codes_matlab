function sq_op = squeeze(z, dim, tol)
%SQUEEZE returns a sparse Fock space squeezing operator with complex
%parameter z, on a system with a cutoff at `dim` - 1 photons. 
%
%We use a tolerance `tol` to clean the matrix up with `sparse_clean`
%before output.
a_sq = a_op(dim)^2;
sq_op = sparse(expm(0.5 * (conj(z) * a_sq - z * a_sq') ));
sq_op = sparse_clean(sq_op, tol);
end