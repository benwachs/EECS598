function dTe_fun = Te_fun2(P)
%returns function handle I hope
    E_string = '';

    for i = 1:length(P)
        if ~strcmpi(P(i).E,'0') 
            E_string = strcat(E_string,P(i).R_str,'*',P(i).E,'+');
        end
        
        if i == length(P)
            E_string = strcat(E_string, '0');
        end
    end
    dTe_string = strcat('1/(c.q_e)*2/3*(1/a.N_e)*((p_abs(t)/c.vol)-c.q_e*(',E_string,'))');
    dTe_fun_test = str2func(['@(a,c,particles,N_tot,t)',dTe_string]);
    dTe_fun{1} = dTe_fun_test;
end