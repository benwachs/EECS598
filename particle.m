classdef particle
    properties
        name = '';
        E_excite = 0 %eV
        charge = 0 %(1 or 0 or -1)
        mass = 0 %kg
        mass_amu = 0 %amu
        sigma = 0 %m
        sigma_angstrom = 0
        epsilon_k = 0 %kelvin
        epsilon_eV = 0 %eV
        mobility = 0 %m^2/s
        mobility_cgs = 0
        reduced = 0
        density = 0
        depend
    end
    methods
        function obj = particle(name,E_excite,charge,mass_amu,sigma_ang,epsilon,mobility)
            PROTONMASS = 1.66054e-27;
            EVTOK = 11604.5;
            if nargin > 0
                obj.name = name;
                obj.E_excite = E_excite;
                obj.charge = charge;
                obj.mass_amu = mass_amu;
                obj.sigma_angstrom = sigma_ang;
                obj.epsilon_k = epsilon; %kelvin
                obj.mobility_cgs = mobility;
                
                obj.mass = PROTONMASS*mass_amu; %kg
                obj.sigma = sigma_ang*10^-10; %meters
                obj.epsilon_eV = epsilon/EVTOK; %eV
                obj.mobility = mobility*10^-4; %m^2/s
                obj.reduced = PROTONMASS*(mass_amu*40)/(mass_amu+40); %reduced mass with Ar %kg
            end
        end
        function diffusion = D(obj,c)
           Kb = 1.38064852e-23; %boltzmann const J/k
           qe = 1.60217662e-19; %electron charge
           if obj.mobility == 0
                diffusion = (3/16)*(1/c.N_T)*(2*pi*Kb*c.T_gas/obj.reduced)^0.5/(pi*obj.sigma^2); %check units
           else
                diffusion = obj.mobility*(c.N_0_atm/c.N_T)*Kb*c.T_ion/qe; %m^2/s
           end
        end
        function test_return = test(obj,b)
           test_return = 5*b; 
        end
        function obj = setDepend(obj, processes)
            temp = zeros(1,length(processes));
            for jj = 1:length(processes) %search over all processes
                for kk = 1:length(processes(jj).input) %search over all inputs
                    if strcmp(processes(jj).input{kk}.name, obj.name)
                        temp(jj) = temp(jj)-1;
                    end
                end
                for mm = 1:length(processes(jj).output) %search over all outputs
                    if strcmp(processes(jj).output{mm}.name, obj.name)
                        temp(jj) = temp(jj)+1;
                    end
                end
            end
            obj.depend = temp;
        end %end set depend
        function dN_return = dN(obj,processes,a)
            dN_return = 0;
        end
         
    end
end

        