function dTg_fun_return = Tg_fun_test(P,particles_array)
% returns 0 (for testing)

    dTg_fun_return{1} = str2func(['@(x,a,c,particles,particles_array,N_tot,t,P)','0']); %make function

end