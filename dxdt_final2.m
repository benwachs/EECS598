function dxdt_return = dxdt_final2(t,x,c,particles,particles_array,P,names,fnc_cells,dTe_fun)
    %NOTE x = a = densities and Temps
    b = num2cell(x); %these two lines turn the array (x) into a struct (a) that is in the format the processes like
    a = cell2struct(b,names);
    
    N_tot = sum(x(1:end-1)'.*([particles_array(:).charge] == 0)); %get density of uncharged particles (for flow stuff) I vectorized this to make it more confusing!
    
    process_return = zeros(length(particles_array)+1,1); %holder for process vals NOTE: the +1 is to include the Te, will have to expand for Ti, Tg
    
    for i = 1:length(P)
        process_return(i) = fnc_cells{i} (a,c,particles,N_tot); %could vectorize this
    end
    
    
    dxdt_return = zeros(length(particles_array)+1,1); %holder for return vals
%     stuff = process_fun(a,c,particles,N_tot,P); 
    
    
    dxdt_return(1:end-1) = (vertcat(particles_array.depend)*process_return)'; %where the magic happens. Multiplies the dependencies by all the process returns
    
    dxdt_return(end-1) = dxdt_return(3)+dxdt_return(7)-dxdt_return(9); %Electron stuff DO BETTER! Sets the number of electrons equal to the number of ions- negative ions.
    
%     N_tot = x(1)+x(2)+x(4)+x(5)+x(6)+x(8); %DO BETTER!
    
    
    
    %FLOW STUFF DO BETTER!! This could all be done programatically, but I
    %got paranoid
    inflowRates = c.flow_rate*[particles_array(:).flowFraction]./c.vol;
    inflowRates = inflowRates(:);
    % This while loop ensures that inflowRates is the same size as x so
    % that we can add them together.
    while numel(inflowRates) < numel(x)
        inflowRates = [inflowRates; 0];     
    end
%     Ar_in = c.f_Ar*c.flow_rate/c.vol;
%     O2_in = c.f_O2*c.flow_rate/c.vol;
    outflowRates = (x./N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
    outflowRates([particles_array(:).charge] ~= 0) = 0;
    % Ensure that outflowRates and x are the same size
    while numel(outflowRates) < numel(x)
        outflowRates = [outflowRates; 0];
    end
%     outflowRates = outflowRates(:); % Make into a column vector
    
%     Ar_out = (x(1)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
%     Ar_ex_out = (x(2)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
%     O2_out = (x(4)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
%     O2_v_out = (x(5)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
%     O2_ex_out = (x(6)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
%     O_out = (x(8)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
%     
%     dxdt_return(1) = dxdt_return(1)+Ar_in; %Ar in
%     dxdt_return(4) = dxdt_return(4)+O2_in; %O2 in
    
%     dxdt_return(1) = dxdt_return(1)-Ar_out; %Ar out
%     dxdt_return(2) = dxdt_return(2)-Ar_ex_out; %Ar_ex out
%     dxdt_return(4) = dxdt_return(4)-O2_out; %O2 out
%     dxdt_return(5) = dxdt_return(5)-O2_v_out;%O2_v out
%     dxdt_return(6) = dxdt_return(6)-O2_ex_out; %O2_ex out
%     dxdt_return(8) = dxdt_return(8)-O_out; %O out
    dxdt_return = dxdt_return + inflowRates - outflowRates;
    
    dxdt_return(end) = dTe_fun{1}(a,c,particles,N_tot,t); %compute the Te. Will have to add line for Tg, Ti
end