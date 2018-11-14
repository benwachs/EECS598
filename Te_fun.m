function dTe = Te_fun(t,a,c,particles,N_tot,P)

    dTe1 = 0;
%     stuff = 0;
    for i = 1:length(P)
        stuff = str2func(strcat('@(a,c,particles,N_tot)',P(i).R_str,'*',P(i).E));
        dTe1 = dTe1 + stuff(a,c,particles,N_tot);
        dTe = 1/(c.q_e) * 2/3*(1/a.N_e)*((p_abs(t)/c.vol)-dTe1*c.q_e);
    end
end