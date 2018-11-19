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
Pressure = T_gas*N_tot_dens*1.38064852e-23;

%%
% first plot
figure
semilogy(t,O_neg_dens*10^-6,t,O2_i_dens*10^-6,t,O_i_dens,'LineWidth',2)
% set(gca,'LineWidth',2)
legend('O^-','O_2^+','O^+')
xlabel('Time')
ylabel('Density, cm^{-3}')
ylim([0,1.2e11])
grid on

%%
% first plot pt 2
figure
semilogy(t,Ar_i_dens*10^-6,t,e_dens*10^-6,'LineWidth',2)
% set(gca,'LineWidth',2)
legend('Ar^+','e')
xlabel('Time')
ylabel('Density, cm^{-3}')
ylim([0,14e11])
grid on
%%
figure
% second plot  TBD
plot(t,e_dens*10^-6,'k',t,Ar_ex_dens*10^-6,'g','LineWidth',2)
ylim([0,15])
ylabel('Density')
legend('e','Ar^*','O_2(v)','O_2^*')
grid on



%%
figure
% third plot
plot(t,e_dens*10^-6,t,Ar_ex_dens*10^-6,'LineWidth',2)
ylabel('Ar^*, e density, cm^-{3}')
xlabel('time')
legend('e','Ar^*')
grid on
%%
figure
%second plot pt 2
plot(t,O2_v_dens*10^-6,t,O2_ex_dens*10^-6,'LineWidth',2);
xlabel('Time')
ylabel('Density, cm^{-3}')
legend('O_2(v)','O_2^*')
grid on

%%
figure
%third plot pt 1
semilogy(t,T_gas,t,T_ion,'LineWidth',2)
xlabel('Time')
ylabel('T (K)')
% ylim([0,1600])
legend('T_{gas}','T_{ion}')
grid on


%% plot pressure
figure
press = (O2_ex_dens+O2_v_dens+O2_dens+O_dens+Ar_dens+Ar_ex_dens);
plot(t,press)

%%
figure
plot(t,e_dens,t,Ar_i_dens+O2_i_dens-O_neg_dens)
figure
%%
plot(t,2*(O2_ex_dens+O2_v_dens+O2_dens)+O_dens)
