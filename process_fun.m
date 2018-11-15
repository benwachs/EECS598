function process_return = process_fun(a,c,particles,N_tot,P)

    stuff = num2cell(zeros(length(P),1)); %holder for fnc handles
    process_return = zeros(length(P),1); %holder for output values
    
    for i = 1:length(P)
        stuff{i} = str2func(['@(a,c,particles,N_tot)', P(i).R_str]); %DO BETTER
        process_return(i) = stuff{i}(a,c,particles,N_tot);
    end
end