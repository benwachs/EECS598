function dTg_fun_return = Tg_fun(P,particles_array)
%returns function handle for Tgas

% charge exchange function
CEX_string = '3/2*c.Kb*(a.Tion-a.Tg)*(';
for i = 1:length(P)     % Iterate through every process
    if strcmpi(P(i).type,'CEX')     % If process is CEX
        CEX_string = [CEX_string, P(i).R_str,'+'];  %
    end
end
CEX_string(end) = ')';

% delta H function
H_string = '3/2*(';
for i = 1:length(P)     % Iterate through every process
    if ~strcmpi(P(i).H,'0')     % If there is delta H
        H_string = [H_string, P(i).R_str, '*', P(i).H, '+'];  %
    end
end
H_string(end) = ')';

% thermal conductivity
k_string ='(';
g_k = '';
for i =1:length(particles_array)
    if particles_array(i).charge == 0 %find neurals
%        g_k = [g_k,'(a.([''N_'',particles_array(i).name])/N_tot)/thermal_conduct(particles_array(i),particles.Ar,a,c) +'];
        g_k = [g_k,'(x(i)/N_tot)/thermal_conduct(particles_array(i),particles.Ar,a,c)+'];
    end    
end
g_k(end) = '';
k_string = [k_string,g_k,')^-1'];


% gas flow energy loss

flow_string = 'c.flow_rate/c.vol*3/2*c.Kb*(c.T_inlet-a.T_gas*(1+(c.Kb*T_gas*N_tot-c.P_0)/c.P_0))';


% electron collisions 
e_string = '3/2*c.Kb*(';
for i = 1:length(P)     % Iterate through every process
    if strcmpi(P(i).type,'elastic')     % If elastic
        e_string = [e_string, P(i).R_str, '*2*c.me/P(i).input{2}.mass*(a.Te*c.eV2K-a.Tg)' , '+'];  %THIS WILL BREAK IF NEUTRAL SPECIES IS NOT SECOND INPUT SPECIES
    end
end
e_string(end) = ')';

% dTg_fun_return_string = ['1/(3/2*c.Kb*N_tot)',CEX_string,'-',H_string,'-',k_string,'+',flow_string,'+',e_string];
dTg_fun_return_string = ['1/(3/2*c.Kb*N_tot)*',CEX_string,'-',H_string,'-',k_string,'+',flow_string,'+',e_string];

dTg_fun_test = str2func(['@(a,c,particles,N_tot,t,P)',dTg_fun_return_string]); %make function

dTg_fun_return{1} = dTg_fun_test; %putting it in a cell MIGHT make it faster

end

