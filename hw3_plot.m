%HW #3 plot


Ar_dens = x(:,1);
O_dens = x(:,8);
O2_dens = x(:,4); 
O2_v_dens = x(:,5);
O2_ex_dens = x(:,6);
e_dens = x(:,10);
Ar_ex_dens = x(:,2);
Ar_i_dens = x(:,3);
O2_i_dens = x(:,7);
O_neg_dens = x(:,9);
%%
% first plot
figure
semilogy(t,Ar_dens*10^-6,t,O_dens*10^-6,t,O2_dens*10^-6,'LineWidth',2)
% set(gca,'LineWidth',2)
legend('Ar','O','O_2')
xlabel('Time')
ylabel('Density, cm^{-3}')
ylim([1e19*10^-6,2e21*10^-6])
grid on
%%
figure
% second plot DOESNT WORK
yyaxis right
plot(t,e_dens*10^-6,'k',t,Ar_ex_dens*10^-6,'g','LineWidth',2)
% ylim([0,2.5])
ylabel('Ar^*, e density')
yyaxis left
plot(t,O2_v_dens*10^-6,t,O2_ex_dens*10^-6,'LineWidth',2);
xlabel('Time')
ylabel('Density, cm^{-3}')
legend('e','Ar^*','O_2(v)','O_2^*')
grid on



%%
figure
% second plot
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
%third plot
semilogy(t,Ar_i_dens*10^-6,t,O2_i_dens*10^-6,t,O_neg_dens*10^-6,'LineWidth',2)
xlabel('Time')
ylabel('Density, cm^{-3}')
legend('Ar^+','O_2^+','O^-')
grid on
yyaxis right
plot(t,x(:,11),'k')
ylabel('Te')
yyaxis left
ylim([1e9,1e12])

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
