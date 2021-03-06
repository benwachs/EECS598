%HW #4 plot

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
%% first plot pt 1
figure
plot(t,O_neg_dens*10^-6*10^-11,t,O2_i_dens*10^-6*10^-11,t,O_i_dens*10^-6*10^-11,'LineWidth',2)
% set(gca,'LineWidth',2)
legend('O^-','O_2^+','O^+')
xlabel('Time')
ylabel('Density, 10^{11}cm^{-3}')
% title('1st Plot #1');
title('Oxygen ion densities');
% ylim([0,1.2])
grid on

%% first plot pt 2
figure
plot(t,Ar_i_dens*10^-6*10^-11,t,e_dens*10^-6*10^-11,'LineWidth',2)
% set(gca,'LineWidth',2)
legend('Ar^+','e')
xlabel('Time')
ylabel('Density, 10^{11} cm^{-3}')
% ylim([0,14])
% title('1st Plot # 2');
title('Ar, e Densities');
grid on
%% NEUTRAL DENSITIES second plot pt 1
figure
plot(t,O2_dens*10^-6*10^-13,t,O_dens*10^-6*10^-13,t,Ar_dens*10^-6*10^-14,t,O2_v_dens*10^-6*10^-12,...
    t,O2_ex_dens*10^-6*10^-12,t,Ar_ex_dens*10^-6*10^-12,'LineWidth',2)
% ylim([0,16])
xlabel('Time')
ylabel('Density, cm^{-3}')
legend('O_2 (10^{13})','O (10^{13})','Ar (10^{14})','O_2(V)(10^{12})','O_2^* (10^{12})','Ar^* (10^{12})')
% title('2nd Plot')
title('Neutral densities')
grid on

%% third plot pt 1 Temperature
figure
plot(t,T_gas,'*',t,T_ion,'LineWidth',2)
xlabel('Time')
ylabel('T (K)')
% ylim([0,1600])
legend('T_{gas}','T_{ion}')
% title('3rd Plot #1');
title('Neutral & Ion Temperature')
grid on



%% Temperature combined
figure
plot(t,T_gas,'*',t,T_ion,'LineWidth',2)
xlabel('Time')
ylabel('T (K)')
% ylim([0,1600])
% title('3rd Plot #1');
title('Temperatures')
grid on
yyaxis right
plot(t,Te,'LineWidth',2)
legend('T_{gas}','T_{ion}','T_e')
ylabel('Te, eV')
set(gca, 'YColor','black')
% ylim([0,1600])


%% first plot combined
figure
plot(t,O_neg_dens*10^-6*10^-11,t,O2_i_dens*10^-6*10^-11,t,O_i_dens*10^-6*10^-11,'LineWidth',2)
% legend('O^-','O_2^+','O^+')
xlabel('Time')
ylabel('Density, 10^{11}cm^{-3}')
% title('1st Plot #1');
title('Oxygen, Ar ion densities');
yyaxis right
plot(t,Ar_i_dens*10^-6*10^-12,t,e_dens*10^-6*10^-12,'LineWidth',2)
% legend('Ar^+','e')
xlabel('Time')
ylabel('Density, 10^{12} cm^{-3}')
% ylim([0,14])
% title('1st Plot # 2');
% title('Ar, e Densities');
legend('O^-','O_2^+','O^+','Ar^+(10^{12})','e (10^{12})')
set(gca, 'YColor','black')
grid on




%% third plot pt 2/ N_tot
figure
plot(t,N_tot_dens*10^-6*10^-14,'LineWidth',2)
xlabel('Time')
ylabel('N_{tot}, 10^{14} cm^{-3}')
% ylim([0,1600])
legend('N_{total}')
title('3rd plot #2 / N_{tot}');
grid on

%% third plot pt 3/ Pressure
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

%%
figure
plot(t,O_atom_dens,t,Ar_atom_dens,t,(Ar_atom_dens+O_atom_dens),'LineWidth',2)

%%
plot(t,2*(O2_ex_dens+O2_v_dens+O2_dens)+O_dens)
