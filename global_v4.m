% close all;
clear;

tic %start timing

t_final_ms = 25; %ms
P_0_mtorr = 50; %Initial gas pressure, mTorr
T_gas_0 = 300; %gas temp, kelvin
T_ion_0 = 300; %ion temp, kelvin
N_e_0_cgs = 10e9; %electron density, cm^-3
Te_0 = 0.5; %electron temp, eV
r_reactor_cgs = 4; %cm
l_reactor_cgs = 30; %cm
flow_rate_sccm = 1000; %sccm
% flow_rate_sccm = 1; %sccm testing

%constants (MKS)
c.q_e =1.60217662e-19;
c.qe = 1.60217662e-19;
c.me = 9.10938e-31; %kg
c.m_e = 9.10938e-31; %kg
c.Kb = 1.38064852e-23; %boltzmann const J/k
c.kb = 1.38064852e-23; %boltzmann const J/k
c.eV2K = 11604.52; %ev to kelvin
c.K2eV = 1/c.eV2K;

%convert units
t_final = t_final_ms/1000; %s
r_reactor = r_reactor_cgs*10^-2; %m
l_reactor = l_reactor_cgs*10^-2; %m
vol = r_reactor^2*pi*l_reactor; %m^3
TgeV = T_gas_0/11604.5; %gas tesmp eV
P_0 = (P_0_mtorr/1000)*133.322; %pascal

%unchanging stuff
c.lambda = r_reactor/2.405;
c.vol = vol;
c.TgeV = TgeV;
c.T_gas = T_gas_0;
c.T_ion = T_ion_0;
c.T_ion_eV = T_ion_0/11604.5;
c.T_wall = 300; %kelvin

c.N_0_atm = 101325/(273*c.Kb); %for diffusion calc
c.N_0 = P_0/(c.Kb*T_gas_0); %m^-3
c.P_0 = P_0;
c.N_T = c.N_0; %forget what this is for

%flow stuff
c.flow_rate = 4.479*10^17*flow_rate_sccm; %atoms/s
c.T_inlet = 300; %kelvin
% c.f_O2 = 0.1;
% c.f_Ar = 0.9;

c.Beta = 0.5;

%load particles and stuff
[particles,P] = HW4_processes(); %load particles and processes
particles.O2 = particles.O2.setFlowFraction(0.1);
particles.Ar = particles.Ar.setFlowFraction(0.9);

%initial conditions
N_Ar_0 = c.N_0*particles.Ar.flowFraction; %m^-3
N_Ar_ex_0 = 0;
N_Ar_i_0 = N_e_0_cgs*10^6; %m^-3 %MIGHT HAVE TO CHANGE
N_O2_0 = c.N_0*particles.O2.flowFraction; %m^-3
N_O2_v_0 = 0;
N_O2_ex_0 = 0;
N_O2_i_0 = 0;
N_O_0 = 0;
N_O_neg_0 = 0;
N_0_i_0 = 0;
N_e_0 = N_e_0_cgs*10^6; %m^-3
T_gas_0 = 300; %kelvin
T_ion_0 = 300; %kelvin


particles_cell = struct2cell(particles); %make a cell array from particles (Struct), this is so it can be iterated through in a for loop, there's probably a better way


for i = 1:length(particles_cell)
    particles_cell{i} = particles_cell{i}.setDepend(P); %initialize depend 
    if i == 4
        particles_cell{i}.depend(41) = particles_cell{i}.depend(41)-0.5; %this is for that Beta term, should be done better but I don't feel like it
    end

    particles_array(i) = particles_cell{i}; %make an array of the particles (I know theres a faster way)
    names{i} = strcat('N_',particles_cell{i}.name); %make a cell array of the density names
end

% Ensure that flow fractions add up to 1
totalFlow = sum([particles_array(:).flowFraction]);
if abs(1 - totalFlow) >.0001
    error('Hey jackass, your flow fractions dont add up to one. Fix it.');
end


names{end+1} = 'Te'; %last name is Te, will have to add Ti, Tg
names{end+1} = 'T_gas'; %last name is Te, will have to add Ti, Tg
names{end+1} = 'T_ion'; %last name is Te, will have to add Ti, Tg

NT = zeros(length(particles_array)+3,1); %Densities/Te: build empty array for initial densities and Te (will add Ti, Tg)
NT(1) = N_Ar_0; %these values were set in the first section
NT(2) = N_Ar_ex_0;
NT(3) = N_Ar_i_0;
NT(4) = N_O2_0;
NT(5) = N_O2_v_0;
NT(6) = N_O2_ex_0;
NT(7) = N_O2_i_0;
NT(8) = N_O_0;
NT(9) = N_O_neg_0;
NT(10) = N_0_i_0;
NT(end-3) = N_e_0;
NT(end-2) = Te_0; %eV
NT(end-1) = T_gas_0; %kelvin
NT(end) = T_ion_0; %kelvin

fnc_cells = process_fun2(P); %this is where the magic happens, this function returns a cell array of fnc handles
dTe_fun = Te_fun2(P); %this returns a cell array (dim 1x1) with the Te function handle
dTg_fun = Tg_fun(P,particles_array);

integrand = @(t,x) dxdt_final2(t,x,c,particles,particles_array,P,names,fnc_cells,dTe_fun,dTg_fun); %this turns the large function into a function of only x,t as ODE45 requires

options= odeset('OutputFcn', @odeplot); %used if you want to plot live

[t,x] = ode45(integrand,[0,t_final],NT);

toc