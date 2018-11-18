% test function handles

[particles,P] = HW4_processes(); %load particles and processes

particles_cell = struct2cell(particles);

for i = 1:length(particles_cell)
    particles_cell{i} = particles_cell{i}.setDepend(P); %initialize depend 
    if i == 4
        particles_cell{i}.depend(41) = particles_cell{i}.depend(41)-0.5; %this is for that Beta term, should be done better but I don't feel like it
    end

    particles_array(i) = particles_cell{i}; %make an array of the particles (I know theres a faster way)
    names{i} = strcat('N_',particles_cell{i}.name); %make a cell array of the density names
end

fnc_cells = process_fun2(P); %this is where the magic happens, this function returns a cell array of fnc handles
dTe_fun = Te_fun2(P); %this returns a cell array (dim 1x1) with the Te function handle
dTg_fun = Tg_fun(P,particles_array);