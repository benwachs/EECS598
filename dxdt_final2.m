function dxdt_return = dxdt_final2(t,x,c,particles,particles_array,P,names,fnc_cells,dTe_fun,dTg_fun)
    %NOTE x = a = densities and Temps
    b = num2cell(x); %these two lines turn the array (x) into a struct (a) that is in the format the processes like
    a = cell2struct(b,names);
    Te = x(end - 1);
    Tg = x(end);
%     Ti = x(end);
    N_tot = sum(x(1:end-2)'.*([particles_array(:).charge] == 0)); %get density of uncharged particles (for flow stuff) I vectorized this to make it more confusing!
    T_ion = T_ion_fun(x,a,c,particles_array,N_tot);
    process_return = zeros(length(P),1); %holder for process vals
    for i = 1:length(P) %gets dN/dt for every process
        process_return(i) = fnc_cells{i} (a,c,particles,N_tot,T_ion); %could (should) vectorize this
    end
    
    dxdt_return = zeros(length(particles_array)+2,1); %holder for return vals
    dxdt_return(1:end-2) = (vertcat(particles_array.depend)*process_return)'; %where the magic happens. Multiplies the dependencies by all the process returns
    
%     dxdt_return(end-1) = dxdt_return(3)+dxdt_return(7)+dxdt_return(10)-dxdt_return(9); %Electron stuff DO BETTER! Sets the number of electrons equal to the number of ions- negative ions.
     dxdt_return(end-2) = sum([particles_array(1:end-1).charge]'.*dxdt_return(1:numel(particles_array)-1)); %find electron density, looks at all particles except electrons hence -1
    
%     N_tot = x(1)+x(2)+x(4)+x(5)+x(6)+x(8); %DO BETTER!    
    
    %flow stuff
    inflowRates = c.flow_rate*[particles_array(:).flowFraction]./c.vol;
    inflowRates = inflowRates(:); %transpose?
    % This while loop ensures that inflowRates is the same size as x so
    % that we can add them together.
    while numel(inflowRates) < numel(x)
        inflowRates = [inflowRates; 0]; %wtf does this do?
    end
%     Ar_in = c.f_Ar*c.flow_rate/c.vol;
%     O2_in = c.f_O2*c.flow_rate/c.vol;
%     outflowRates = (x./N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol); %old version
    outflowRates = (x./N_tot)*(1+10*(N_tot*c.Kb*a.T_gas-c.P_0)/(c.P_0))*(c.flow_rate/c.vol); %new version 
    outflowRates([particles_array(:).charge] ~= 0) = 0;
    % Ensure that outflowRates and x are the same size
    while numel(outflowRates) < numel(x)
        outflowRates = [outflowRates; 0];
    end
%     outflowRates = outflowRates(:); % Make into a column vector
    
    dxdt_return = dxdt_return + inflowRates - outflowRates;
    
    dxdt_return(end-1) = dTe_fun{1}(a,c,particles,N_tot,t); %compute Te
    dxdt_return(end) = dTg_fun{1}(x,a,c,particles,particles_array,N_tot,t,P,T_ion); %compute T_gas
%     posIonLocs = [particles_array(:).charge] > 0;
%     N_i_total = sum(x(1:end-2)'.*(posIonLocs));
%     dN_i_total_dt = sum(dxdt_return(1:end-3)'.*(posIonLocs));
%     
%     dTidt = 0;
%     for i = 1:numel(posIonLocs) % There's a faster way to do this, but fuck it
%         dTidt = dTidt + c.qe/c.kb*posIonLocs(i).*(particles_array(i).mobility*c.N_0_atm/N_tot)^2*particles_array(i).mass*(...
%         2*Te*x(i)./N_i_total*dxdt_return(end-2) + (N_i_total*dxdt_return(i) - x(i)*dN_i_total_dt)/N_i_total^2*Te^2);
%     end
%     dxdt_return(end) = dxdt_return(end - 1) + dTidt*(1/c.lambda)^2*(1/3/c.kb);
%     dxdt_return(end) = dxdt_return(end-1); %set T_ion = T_gas for debugging
%     dxdt_return(end) = findIonTemperature(x,c,particles_array) - x(end); %compute T_ion TEST EDITION
end