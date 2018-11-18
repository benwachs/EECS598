function pow = p_abs(t)
    p_end = 500;
    p_init = .1;
    rampTime = 200*10^-6;
    
    
    % Allowing for vector input/output just allows us to plot power as a
    % function of time more easily.
    pow = zeros(size(t));
    pow(t < rampTime) = 0.1+t(t<rampTime)/rampTime*(p_end-p_init);
    pow(t >= rampTime) = p_end;
%     if (t < rampTime)
%         pow = 0.1+t/rampTime*(p_end-p_init);
%     else
%         pow = p_end;
%     end
    
    %testing git stuff
end