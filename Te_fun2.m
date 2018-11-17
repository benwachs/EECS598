function dTe_fun = Te_fun2(P)
%returns function handle I hope

    %% Form electron temperature handle
    E_string = '';

    for i = 1:length(P)     % Iterate through every process
        if ~strcmpi(P(i).E,'0')     % If there is no delta epsilon
            E_string = [E_string, P(i).R_str, '*', P(i).E, '+'];  % 
        end
        
        if i == length(P)   % Why add a zero to the last process?
            E_string = [E_string, '0']; % Idk what this does
        end
    end
    dTe_string = strcat('1/(c.q_e)*2/3*(1/a.N_e)*((p_abs(t)/c.vol)-c.q_e*(',E_string,'))');
    dTe_fun_test = str2func(['@(a,c,particles,N_tot,t)',dTe_string]);
    dTe_fun{1} = dTe_fun_test;
end