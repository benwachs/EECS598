function pow = p_abs(t)
    p_end = 500; %changed from 100 W
    if (t<200*10^-6)
        pow = 0.1+t/(200*10^-6)*(p_end-0.1);
    else
        pow = p_end;
    end
end