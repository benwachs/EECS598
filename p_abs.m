function pow = p_abs(t)
    p_end = 100;
    if (t<200*10^-6)
        pow = 0.1+t/(200*10^-6)*(p_end-0.1);
    else
        pow = p_end;
    end
    
    %testing git stuff
end