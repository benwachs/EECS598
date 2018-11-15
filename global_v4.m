%test_script
%inputs
tic %start timing

t_final_ms = .05;
P_0_mtorr = 50; %Initial gas pressure, mTorr
T_gas_0 = 300; %gas temp, kelvin
T_ion_0 = 300; %ion temp, kelvin
N_e_0_cgs = 10e9; %electron density, cm^-3
Te_0 = 0.5; %electron temp, eV
r_reactor_cgs = 4; %cm
l_reactor_cgs = 30; %cm
flow_rate_sccm = 3000; %sccm
% flow_rate_sccm = 1; %sccm testing

%constants (MKS)
c.q_e =1.60217662e-19;
c.qe = 1.60217662e-19;
c.me = 9.10938e-31; %kg
c.m_e = 9.10938e-31; %kg
c.Kb = 1.38064852e-23; %boltzmann const J/k
c.kb = 1.38064852e-23; %boltzmann const J/k

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

c.N_0_atm = 101325/(273*c.Kb); %for diffusion calc
c.N_0 = P_0/(c.Kb*T_gas_0); %m^-3
c.N_T = c.N_0; %forget what this is for

%flow stuff
c.flow_rate = 4.479*10^17*flow_rate_sccm; %atoms/s
c.f_O2 = 0.1;
c.f_Ar = 0.9;
c.Beta = 0.3;

%initial conditions
N_Ar_0 = c.N_0*c.f_Ar; %m^-3
N_Ar_ex_0 = 0;
N_Ar_i_0 = N_e_0_cgs*10^6; %m^-3 %MIGHT HAVE TO CHANGE
N_O2_0 = c.N_0*c.f_O2; %m^-3
N_O2_v_0 = 0;
N_O2_ex_0 = 0;
N_O2_i_0 = 0;
N_O_0 = 0;
N_O_neg_0 = 0;
N_e_0 = N_e_0_cgs*10^6; %m^-3

%load particles and stuff
[particles,P] = process_test4(); %load particles and processes

particles_cell = struct2cell(particles);
for i = 1:length(particles_cell)
%     particles_cell{i}.setDepend(P); %initialize depend
    particles_cell{i} = particles_cell{i}.setDepend(P); %initialize depend
    if i == 4
        particles_cell{i}.depend(41) = particles_cell{i}.depend(41)-0.5;
    end

    particles_array(i) = particles_cell{i};
    names{i} = strcat('N_',particles_cell{i}.name);
end


names{end+1} = 'Te';

NT = zeros(length(particles_array)+1,1); %Densities/Te: build empty array for initial densities and Te
NT(1) = N_Ar_0;
NT(2) = N_Ar_ex_0;
NT(3) = N_Ar_i_0;
NT(4) = N_O2_0;
NT(5) = N_O2_v_0;
NT(6) = N_O2_ex_0;
NT(7) = N_O2_i_0;
NT(8) = N_O_0;
NT(9) = N_O_neg_0;
NT(end-1) = N_e_0;
NT(end) = Te_0; %eV

integrand = @(t,x) dxdt_final(t,x,c,particles,particles_array,P,names);
options= odeset('OutputFcn',@odeplot);

[t,x] = ode45(integrand,[0,t_final],NT,options);

toc