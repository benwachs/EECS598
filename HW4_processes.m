%HW 3
function [particles, p] = HW4_processes()

    %particles
    Ar = particle('Ar',0,0,40,3.542,93.3,0); %1
    Ar_ex = particle('Ar_ex',11.6,0,40,3.542,93.3,0); %2
    Ar_i = particle('Ar_i',16.0,1,40,0,0,1.53); %3
    O2 = particle('O2',0,0,32,3.47,106.7,0); %ground state O2 %4
    O2_v = particle('O2_v',0.19,0,32,3.47,106.7,0); %vibrational state O2 %5
    O2_ex = particle('O2_ex',0.977,0,32,3.47,106.7,0); %electronic state O2 %6
    O2_i = particle('O2_i',12.3,1,32,0,0,2.57); %O2 ion %7
    O = particle('O',0,0,16,3.05,106.7,0); %ground state O atom %8
    O_neg = particle('O_neg',0,-1,16,0,0,3.00); %negative ion of O %9
    O_i = particle('O_i',0,1,16,0,0, 0); %positive ion of O. Mobility
%     currently = 0? %10
    
    e = particle('e',0,-1,5.46e-4,0,0,0); %11
    
%     particles = [Ar,Ar_ex,Ar_i,e];
    
    particles.Ar = Ar;
    particles.Ar_ex = Ar_ex;
    particles.Ar_i = Ar_i;
    particles.O2 = O2;
    particles.O2_v = O2_v;
    particles.O2_ex = O2_ex;
    particles.O2_i = O2_i;
    particles.O = O;
    particles.O_neg = O_neg;
    particles.O_i = O_i;
    particles.e = e;
    %processes
    
    yy = 11;
    xx = 14;
    
    p(1) = process1({e,Ar},{Ar,e},... %elastic
        '3.9*10^-7*exp(-4.6/(a.Te+0.5))*10^-6',...
        '2*c.m_e/particles.Ar.mass*(3/2)*(a.Te-c.TgeV)'); %note the c
    p(2) = process1({e, Ar},{Ar_ex,e},...
        '2.5*10^-9*a.Te^0.74*exp(-11.7/a.Te)*10^-6',...
        '11.6');
    p(3) = process1({e, Ar},{Ar_i,e,e},...
        '2.3*10^-8*a.Te^0.68*exp(-16/a.Te)*10^-6',...
        '16.0');
    p(4) =  process1({e, Ar_ex},{Ar,e},... %superelastic
        '4.3*10^-10*a.Te^0.74*10^-6',...
        '-11.6');
    p(5) = process1({e,Ar_ex},{Ar_i,e,e},... %multistep
        '6.8*10^-9*a.Te^0.67*exp(-4.4/a.Te)*10^-6',...
        '4.4');
    p(6) = process1({Ar_ex},{Ar},... %mixed state radiation trapping
        '10^5*(3*10^20/a.N_Ar)','0');
    p(7) = process1({e,Ar_i},{Ar_ex},... %radiative recombination
        '4.3*10^-13*a.Te^-0.63*10^-6','0');
    p(8) = process1({e,e,Ar_i},{Ar_ex,e},... %collisional radiative recombination
        '1.95*10^-27*a.Te^-4.5*10^-12','0');
    p(9) = process1({Ar_ex,Ar_ex},{Ar_i,Ar,e},... %penning ionization
        '1.2*10^-9*10^-6','0');
    p(10) = process1({Ar_i},{Ar},... % wall neutralization
        'particles.Ar_i.D(c)*(1+(a.Te/c.T_ion_eV))/c.lambda^2','0');
%     p(11) = process1({e},{},... % wall neutralization (e)
%         'particles.Ar_i.D(c)*(1+(a.Te/c.T_ion_eV))/c.lambda^2','0');
    p(11) = process1({Ar_ex},{Ar},... % wall quenching
        'particles.Ar.D(c)/c.lambda^2','0'); 
    
    p(yy+1) = process1({e,O2},{O2,e},... %elastic ADD STUFF!!
        '4.79*10^-8*a.Te^0.5 *10^-6',...
        '2*c.m_e/particles.O2.mass*(3/2)*(a.Te-c.TgeV)');
    p(yy+2) = process1({e,O2_v},{O2_v,e},... %elastic ADD STUFF!!
        '4.79*10^-8*a.Te^0.5 *10^-6',...
        '2*c.m_e/particles.O2_v.mass*(3/2)*(a.Te-c.TgeV)');
    p(yy+3) = process1({e,O2_ex},{O2_ex,e},... %elastic ADD STUFF!!
        '4.79*10^-8*a.Te^0.5 *10^-6',...
        '2*c.m_e/particles.O2_ex.mass*(3/2)*(a.Te-c.TgeV)');
    p(yy+4) = process1({e,O},{O,e},... %elastic ADD STUFF!!
        '4.79*10^-8*a.Te^0.5 *10^-6',...
        '2*c.m_e/particles.O.mass*(3/2)*(a.Te-c.TgeV)');
    
    
    p(xx+2) = process1({e,O2},{O,O,e},... %dissociation
        '6.86*10^-9*exp(-6.29/a.Te) *10^-6',...
        '6.29');
    p(xx+3) = process1({e,O2},{O,O,e},...%dissociation #2?
        '3.49*10^-9*exp(-5.92/a.Te) *10^-6',...
        '5.92');
    p(xx+4) = process1({e,O2},{O,O_neg},... %dissociative attachment
        '1.07*10^-9*a.Te^-1.39*exp(-6.26/a.Te) *10^-6','0');
    p(xx+5)= process1({e,O2},{O2_v,e},... %vibrational excitation
        '2.80*10^-9*exp(-3.72/a.Te) *10^-6',...
        '0.19');
    p(xx+6) = process1({e,O2},{O2_v,e},... %vibrational #2
        '1.28*10^-9*exp(-3.67/a.Te) *10^-6',...
        '0.385');
    p(xx+7) = process1({e,O2},{O2_ex,e},... %electronic
        '1.37*10^-9*exp(-2.14/a.Te) *10^-6',...
        '0.977');
    p(xx+8) = process1({e,O2},{O2_i,e,e},... %ionization
        '2.34*10^-9*a.Te^1.03*exp(-12.3/a.Te) *10^-6',...
        '12.3');
    p(xx+9) = process1({e,O2_v},{O2,e},... %super elastic relax
        '2.80*10^-9*exp(-3.53/a.Te) *10^-6',...
        '-0.19');
    p(xx+10) = process1({e,O2_v},{O2_i,e,e},... %ionization #2
        '2.34*10^-9*a.Te^1.03*exp(-12.11/a.Te) *10^-6',...
        '12.11');
    p(xx+11) = process1({e,O2_v},{O,O,e},... %dissociation #3
        '6.86*10^-9*exp(-6.1/a.Te) *10^-6',...
        '6.10');
    p(xx+12) = process1({e,O2_v},{O,O,e},... %dissociation #4
        '3.49*10^-9*exp(-5.73/a.Te) *10^-6',...
        '5.73');
    p(xx+13) = process1({e,O2_v},{O,O_neg},... %dissociative attachment #2
        '1.07*10^-9*a.Te^-1.39*exp(-6.26/a.Te) *10^-6','0');
    p(xx+14) =  process1({e,O2_ex},{O2,e},... %superelastic #2
        '2.06*10^-9*exp(-1.163/a.Te) *10^-6',...
        '-0.977');
    p(xx+15) = process1({e,O2_ex},{O2_i,e,e},... %ionization #3
        '2.34*10^-9*a.Te^1.03*exp(-11.32/a.Te) *10^-6',...
        '11.32');
    p(xx+16) = process1({e,O2_ex},{O,O,e},... %dissociation #5
        '6.86*10^-9*exp(-5.31/a.Te) *10^-6',...
        '5.31');
    p(xx+17) = process1({e,O2_ex},{O,O,e},... %dissociation #6
        '3.49*10^-9*exp(-4.94/a.Te) *10^-6',...
        '4.94');
    p(xx+18) = process1({e,O2_ex},{O,O_neg},... %dissociative attach #3
        '1.07*10^-9*a.Te^-1.39*exp(-6.26/a.Te) *10^-6','0');
    p(xx+19) = process1({O_neg,Ar_i},{O,Ar},...%ion ion neutralization
        '5.0*10^-8*(300/c.T_gas)^0.5 *10^-6','0');
    p(xx+20) = process1({O_neg,O2_i},{O,O2},... %ion ion neutralization #2
        '5.0*10^-8*(300/c.T_gas)^0.5 *10^-6','0');
    p(xx+21) = process1({e,O2_i},{O,O},... %disscociative recomb
        '2.2*10^-8*a.Te^-0.5 *10^-6','0');
    p(xx+22) = process1({Ar_i,O2},{O2_i,Ar},... %CEX
        '4.9*10^-11*(300/c.T_gas)^0.78 *10^-6','0');
    p(xx+23) = process1({Ar_ex,O2},{O,O,Ar},... %dissociative quenching
        '1.0*10^-10 *10^-6','0');
    
    p(xx+24) = process1({O2_i},{O2},...%ion neutralization on wall
        'particles.O2_i.D(c)*(1+(a.Te/c.T_ion_eV))/c.lambda^2','0');
% % %     p(xx+25) = process1({e},{O2},...%ion neutralization on wall (e)
% % %         'particles.O2_i.D(c)*(1+(a.Te/c.T_ion_eV))/c.lambda^2','0');
% % % 
    p(xx+25) = process1({O2_ex},{O2},... %metastable quenching on wall
        'particles.O2_ex.D(c)/c.lambda^2','0');
    p(xx+26) = process1({O2_v},{O2},... %vibrational quenching on wall
        'particles.O2_v.D(c)/c.lambda^2','0');
    p(xx+27) = process1({O},{O2},... %recomb with sticking 1
        '(c.Beta/2)*particles.O.D(c)/c.lambda^2','0');
    p(xx+28) = process1({O},{O},... %recomb with sticking 2
        '(1-c.Beta)*particles.O.D(c)/c.lambda^2','0');
    
    
%     The following processes are for homework 4.
    p = [p, process1({e, O}, {e, O}, '10^-7*10^-6', '0')];  % Elastic collisions
%     
    p = [p, process1({e, O}, {O_i, e, e}, '9*10^-9*a.Te^.7*exp(-13.62/a.Te)*10^-6', '13.62')];
%     
    p = [p, process1({O_neg, O_i}, {O, O}, '9*10^-9*a.Te^.7*exp(-13.62/a.Te)*10^-6', '0')];
%     
    p = [p, process1({O_neg, O}, {O2, e}, '2.3*10^-10*(c.T_gas/300)^.5*10^-6', '0')];
%     
    p = [p, process1({O, Ar_i}, {O_i, Ar}, '6.4*10^-12*(c.T_gas/300)^.5*10^-6', '0')];
%     
    p = [p, process1({O_i, O2}, {O, O2_i}, '2*10^-11*(c.T_gas/300)^.5*10^-6', '0')];
%     
    p = [p, process1({e, O_neg}, {O, e, e}, '5.47*10^-8*a.Te^.324*exp(-2.98/a.Te)*10^-6', '0')];
    
    particles_cell = struct2cell(particles);    % Having to remake this for indexing
    for i = 1:numel(particles_cell)
        if particles_cell{i}.charge == 0
            p = [p, process1({O2_v, particles_cell{i}}, {O2, particles_cell{i}}, '2.0*10^-12*(c.T_gas/300)^0.5*10^-6', '0')];
        end
    end
    
end