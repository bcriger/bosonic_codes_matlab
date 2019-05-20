function photon_number = n_cat_code(alfa)
%N_CAT_CODE returns the average photon number for a cat code state with
%parameter alfa. For the record, those code states are: 
%| \psi_{alfa} > = (| alfa > + | -alfa >) / (sqrt(2 (1 + exp(-2 * |alfa|^2) )))
norm_alfa = abs(alfa)^2;
photon_number = norm_alfa * (1 - exp(-2 * norm_alfa)) / (1 + exp(-2 * norm_alfa));
end