function dTg_fun_return = Tg_fun_test(P,particles_array)

    dTg_fun_return{1} = str2func(['@(x,a,c,particles,particles_array,N_tot,t,P)','407']); %make function

end