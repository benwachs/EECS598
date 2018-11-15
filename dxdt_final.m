function dxdt_return = dxdt_final(t,x,c,particles,particles_array,P,names)
    b = num2cell(x);
    a = cell2struct(b,names);
    
    N_tot = sum(x(1:end-1)'.*([particles_array(:).charge] == 0)); %get density of uncharged particles
    
    dxdt_return = zeros(length(particles_array)+1,1); %holder for return vals
    stuff = process_fun(a,c,particles,N_tot,P); 
%     for i = 1:length(particles_array)
%         dxdt_return(i) = particles_array(i).depend*stuff; %transpose stuff?
%     end
   dxdt_return(1:end-1) = (vertcat(particles_array.depend)*stuff)';
   dxdt_return(end-1) = dxdt_return(3)+dxdt_return(7)-dxdt_return(9); %Electron stuff

    %N_tot = x(1)+x(2)+x(3)+x(4)+x(5)+x(6)+x(7)+x(8)+x(9);
    N_tot = x(1)+x(2)+x(4)+x(5)+x(6)+x(8);
%     N_tot_Ar = x(1)+x(2);
%     N_tot_O = 2*(x(4)+x(5)+x(6))+x(8);
    
    Ar_in = c.f_Ar*c.flow_rate/c.vol;
    O2_in = c.f_O2*c.flow_rate/c.vol;
    
%     Ar_out = (x(1)/(N_tot_Ar))*(1+(N_tot_Ar-c.f_Ar*c.N_0)/(c.f_Ar*c.N_0))*(c.f_Ar*c.flow_rate/c.vol);
%     Ar_ex_out = (x(2)/(N_tot_Ar))*(1+(N_tot_Ar-c.f_Ar*c.N_0)/(c.f_Ar*c.N_0))*(c.f_Ar*c.flow_rate/c.vol);
%     
%     O2_out = 2*(2*x(4)/N_tot_O)*(1+(N_tot_O-2*c.f_O2*c.N_0)/(2*c.f_O2*c.N_0))*(2*c.f_O2*c.flow_rate/c.vol);
%     O2_v_out = 2*(2*x(5)/N_tot_O)*(1+(N_tot_O-2*c.f_O2*c.N_0)/(2*c.f_O2*c.N_0))*(2*c.f_O2*c.flow_rate/c.vol);
%     O2_ex_out = 2*(2*x(6)/N_tot_O)*(1+(N_tot_O-2*c.f_O2*c.N_0)/(2*c.f_O2*c.N_0))*(2*c.f_O2*c.flow_rate/c.vol);
%     O_out = (x(8)/N_tot_O)*(1+(N_tot_O-2*c.f_O2*c.N_0)/(2*c.f_O2*c.N_0))*(2*c.f_O2*c.flow_rate/c.vol);
    
    Ar_out = (x(1)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
    Ar_ex_out = (x(2)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
    O2_out = (x(4)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
    O2_v_out = (x(5)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
    O2_ex_out = (x(6)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
    O_out = (x(8)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
    
    dxdt_return(1) = dxdt_return(1)+Ar_in; %Ar in
    dxdt_return(4) = dxdt_return(4)+O2_in; %O2 in
    
    dxdt_return(1) = dxdt_return(1)-Ar_out; %Ar out
    dxdt_return(2) = dxdt_return(2)-Ar_ex_out; %Ar_ex out
    dxdt_return(4) = dxdt_return(4)-O2_out; %O2 out
    dxdt_return(5) = dxdt_return(5)-O2_v_out;%O2_v out
    dxdt_return(6) = dxdt_return(6)-O2_ex_out; %O2_ex out
    dxdt_return(8) = dxdt_return(8)-O_out; %O out
    
    %inflow stuff
%     idx_Ar = find(strcmp(names(:), 'N_Ar'));
%     idx_O2 = find(strcmp(names(:), 'N_O2')); 
%     idx_Ar = 1; %do better here
%     idx_O2 = 4;
%     dxdt_return(idx_Ar) = dxdt_return(idx_Ar)+c.f_Ar*c.flow_rate/c.vol;
%     dxdt_return(idx_O2) = dxdt_return(idx_O2)+c.f_O2*c.flow_rate/c.vol;

    %outflow stuff
%     N_tot = sum(x(1:end-1)'.*([particles_array(:).charge] == 0));
%     
%     for i = 1:length(particles_array)
%         if particles_array(i).charge ==0
%             outflow = -(x(i)/N_tot)*(1+(N_tot-c.N_0)/c.N_0)*(c.flow_rate/c.vol);
%             dxdt_return(i) = dxdt_return(i)+outflow;
%         end
%     end
%      if t > 0.15*10^-3
%          xxxxx = 1;
%      end

    
    dxdt_return(end) = Te_fun(t,a,c,particles,N_tot,P);
end