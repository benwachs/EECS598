%HW #5 plot

Ar_dens = x(:,1);
O_dens = x(:,8);
O2_dens = x(:,4); 
O2_v_dens = x(:,5);
O2_ex_dens = x(:,6);
Ar_ex_dens = x(:,2);
Ar_i_dens = x(:,3);
O2_i_dens = x(:,7);
O_neg_dens = x(:,9);
O_i_dens = x(:,10);
e_dens = x(:,end-2);
Te = x(:,end-1);
T_gas = x(:,end);
% T_ion = x(:,end);

O_atom_dens = O_dens+2*(O2_dens+O2_v_dens+O2_ex_dens+O2_i_dens)+O_neg_dens+O_i_dens;
Ar_atom_dens = Ar_dens+Ar_ex_dens+Ar_i_dens;

N_tot_dens = Ar_dens+O_dens+O2_dens+O2_v_dens+O2_ex_dens+Ar_ex_dens;
pressure = T_gas.*N_tot_dens*1.38064852e-23*0.00750062*1000; %mTorr
N_tot_ion_dens = Ar_i_dens+O2_i_dens+O_i_dens;
ion_locs = [particles_array(:).charge]>0;
T_ion= T_gas + 1./(3*c.Kb*N_tot_ion_dens).*...
    sum(x(:,ion_locs).*[particles_array(ion_locs).mass].*([particles_array(ion_locs).mobility].*c.N_0_atm./N_tot_dens.*Te./c.lambda).^2,2);

T_g_final = T_gas(end);
dissociation_final = O_dens(end)/(.5*O_dens(end)+O2_dens(end)+O2_v_dens(end)+O2_ex_dens(end));
disp(['Tg final: ',num2str(T_g_final),', diss final: ',num2str(dissociation_final),', power:' num2str(p_abs(t(end)))]);

%% #1 Temperature & Ne combined
figure
plot(t,e_dens*10^-6*10^-12,'LineWidth',1.5)
xlabel('Time')
ylabel('Electron Density (10^{12} cm^{-3})')
% ylim([0,1600])
% title('3rd Plot #1');
title('Electron Density & T_e')
grid on
yyaxis right
plot(t,Te,'LineWidth',2)
legend('N_e','T_e')
ylabel('Te, eV')
set(gca, 'YColor','black')
% ylim([0,1600])

%% #2 Temperature & Ne combined LAST ONE
figure
plot(t,e_dens*10^-6*10^-12,'LineWidth',1.5)
xlabel('Time')
ylabel('Electron Density (10^{12} cm^{-3})')
% ylim([0,1600])
% title('3rd Plot #1');
title('Electron Density & T_e')
grid on
yyaxis right
plot(t,Te,'LineWidth',2)
legend('N_e (10^{12})','T_e')
ylabel('Te, eV')
set(gca, 'YColor','black')
xlim(10^-3*[5.4,6.0])
% ylim([0,1600])

%% #3 Ar*, O, & T_gas combined 
figure
plot(t,Ar_ex_dens*10^-6*10^-12,t,O_dens*10^-6*10^-14,'LineWidth',1.5)
xlabel('Time')
ylabel('Ar^* (10^{12} cm^{-3}), O (10^{14} cm^{-3})')
title('Ar^*, O Densities & T_{gas}');
yyaxis right
plot(t,T_gas,'LineWidth',2)
xlabel('Time')
ylabel('T_{gas} (K)')
legend('Ar^*(10^{12})','O(10^{14})','T_{gas}')
set(gca, 'YColor','black')
grid on

%% #4 Ar*, O, & T_gas combined 
figure
plot(t,Ar_ex_dens*10^-6*10^-12,t,O_dens*10^-6*10^-14,'LineWidth',1.5)
xlabel('Time')
ylabel('Ar^* (10^{12} cm^{-3}), O (10^{14} cm^{-3})')
title('Ar^*, O Densities & T_{gas}');
yyaxis right
plot(t,T_gas,'LineWidth',2)
xlabel('Time')
ylabel('T_{gas} (K)')
legend('Ar^*(10^{12})','O(10^{14})','T_{gas}')
set(gca, 'YColor','black')
xlim(10^-3*[5.4,6.0])
grid on

%% Pressure
figure
plot(t,pressure,'LineWidth',2)
xlabel('Time')
ylabel('Pressure, mTorr')
% ylim([0,1600])
legend('Pressure')
title('3rd Plot #3 / Pressure');
grid on

%% Fourth plot pt 1/ Te
figure
plot(t,Te,'LineWidth',2)
xlabel('Time')
ylabel('Te, eV')
% ylim([0,1600])
legend('Te')
title('Electron Temperature');
grid on


%% testing stuff
figure
plot(t,T_ion,'LineWidth',2)
figure
plot(t,T_gas,'LineWidth',2)