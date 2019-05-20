function dsp_op = displace(alfa, dim, tol)
%SQUEEZE returns a sparse Fock space displacement operator with complex
%parameter `alfa`, on a system with a cutoff at `dim` - 1 photons. 
%
%We use a tolerance `tol` to clean the matrix up with `sparse_clean`
%before output.
a = a_op(dim);
dsp_op = sparse(expm( alfa * a' - conj(alfa) * a ));
dsp_op = sparse_clean(dsp_op, tol);
end