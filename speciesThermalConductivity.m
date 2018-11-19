function kappa = speciesThermalConductivity(species, particles_array, T_gas, c)
%% kappa = speciesThermalConductivity(species, particles, T_gas, c) computes the thermal conductivity for a certain species
% species is the particle for which you want the thermal conductivity,
% particles_array is an object array of all particles (can include charged
% states), T_gas is the current gas temperature, and c is our constants.

% Find all species that don't have charge (i.e. the collision partners)
collisionPartners = [];
for i = 1:numel(particles_array)
    if particles_array(i).charge == 0
        collisionPartners = [collisionPartners, particles_array(i)];
    end
end
% Find the mean mass of the collision partners
avgMass = mean(sum([collisionPartners(:).mass]));
% Find average Lennard Jones radius
avgSigmaLJ = mean(sum([collisionPartners(:).sigma]));
% Coefficient out front
coef = 25/34*3/2*c.kb;
numerator = ((species.mass + avgMass)*pi*c.kb*T_gas/2/species.mass/avgMass)^.5;
denominator = pi*avgSigmaLJ^2;
kappa = coef*numerator/denominator;
end