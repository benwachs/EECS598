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
e_dens = x(:,end-3);
Te = x(:,end-2);
T_gas = x(:,end-1);
T_ion = x(:,end);

N_tot_dens = Ar_dens+O_dens+O2_dens+O2_v_dens+O2_ex_dens+Ar_ex_dens;
pressure = T_gas.*N_tot_dens*1.38064852e-23*0.00750062*1000; %mTorr

%% first plot pt 1
figure
plot(t,O_neg_dens*10^-6*10^-11,t,O2_i_dens*10^-6*10^-11,t,O_i_dens*10^-6*10^-11,'LineWidth',2)
% set(gca,'LineWidth',2)
legend('O^-','O_2^+','O^+')
xlabel('Time')
ylabel('Density, 10^{11}cm^{-3}')
title('1st plot pt 1');
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
title('1st plot pt 2');
grid on
%% second plot pt 1
figure
plot(t,O2_dens*10^-6*10^-13,t,O_dens*10^-6*10^-13,t,Ar_dens*10^-6*10^-14,t,O2_v_dens*10^-6*10^-12,'LineWidth',2)
% ylim([0,16])
ylabel('Density')
legend('O_2','O','Ar','O_2(V)')
grid on

%% third plot pt 1 Temperature
figure
plot(t,T_gas,'*',t,T_ion,'LineWidth',2)
xlabel('Time')
ylabel('T (K)')
% ylim([0,1600])
legend('T_{gas}','T_{ion}')
title('3rd plot pt 1');
grid on

%% third plot pt 2/ N_tot
figure
plot(t,N_tot_dens*10^-6*10^-14,'LineWidth',2)
xlabel('Time')
ylabel('N_tot, 10^{14} cm^{-3}')
% ylim([0,1600])
legend('N_{total}')
title('3rd plot pt 2 / N_{tot}');
grid on

%% third plot pt 3/ Pressure
figure
plot(t,pressure,'LineWidth',2)
xlabel('Time')
ylabel('Pressure, mTorr')
% ylim([0,1600])
legend('Pressure')
title('3rd plot pt 3 / Pressure');
grid on

%% Fourth plot pt 1/ Te
figure
plot(t,Te,'LineWidth',2)
xlabel('Time')
ylabel('Te, eV')
% ylim([0,1600])
legend('Te')
title('4th plot pt 1 / Te');
grid on
%% testing stuff
figure
plot(t,T_ion,'LineWidth',2)
figure
plot(t,T_gas,'LineWidth',2)

%%
figure
plot(t,e_dens,t,Ar_i_dens+O2_i_dens-O_neg_dens)
figure
%%
plot(t,2*(O2_ex_dens+O2_v_dens+O2_dens)+O_dens)
