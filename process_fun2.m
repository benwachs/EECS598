function fnc_cells = process_fun2(P)

    fnc_cells = num2cell(zeros(length(P),1)); %holder for fnc handles    
    for i = 1:length(P)
        try
            fnc_cells{i} = str2func(['@(a,c,particles,N_tot)', P(i).R_str]); %DO BETTER
        catch
            disp('wtf');
        end
    end
end