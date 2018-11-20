function T_ion_return = T_ion_fun(x,a,c,particles_array,N_tot)
% determines Ion temp from Te and stuff
N_tot_ion = sum(x([particles_array(:).charge]>0));
ion_locs = [particles_array(:).charge]>0;
T_ion_return = a.T_gas + 1/(3*c.Kb*N_tot_ion)*...
    sum(x(ion_locs)'.*[particles_array(ion_locs).mass].*([particles_array(ion_locs).mobility].*c.N_0_atm/N_tot*a.Te/c.lambda).^2);

end
