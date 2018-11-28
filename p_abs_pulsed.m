function pow = p_abs_pulsed(t)
    P_avg = 200;
    f_dc = .15; %duty cycle
    pulse_rep = 2e3;
    t_ramp = 2e-6; %ramp time, s
    P_min = 5e-4; %minimum power (for numerical errors)
    
    pulse_period = 1/pulse_rep;
    t_on = pulse_period*f_dc;
    P_max = P_avg/f_dc;
    
    x = mod(t,pulse_period);
    
    if (x < t_ramp) %up ramp
        pow = P_max*x/t_ramp + P_min;
    elseif (x > t_ramp) && (x < (t_on-t_ramp)) %on
        pow = P_max + P_min;
    elseif (x > (t_on-t_ramp)) && (x < t_on) %downramp
        pow = P_max*(1-(x-(t_on-t_ramp))/t_ramp) + P_min;
    else
        pow = P_min;
    end
    
    
end