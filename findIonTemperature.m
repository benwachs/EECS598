function Ti = findIonTemperature(x, c, particles_array)
%% Ti = findIonTemperature(Tg, Te, c, particle_array) determines ion temperature according to page 5 of homework 4
% x is just the output of the odesolver.
% c is the typical list of constants, and particle_array is an array
% of particle objects that will get filtered by charge.

TELOC = size(x, 2) - 2;   % Index of electron temperature
TGLOC = size(x, 2) - 1;       % Index of gas temperature

%% Find all ions
posIonLocs = find([particles_array(:).charge]==1);    % Locations of the positive ions
posIons = particles_array(posIonLocs);          % Positive ion objects

%% Find vectors representing the mole fractions of each ion
% Find total ion density
ionDensity = 0;
for i = posIonLocs
    ionDensity = ionDensity + x(i);
end
% Define mole fractions
moleFractions = zeros(size(x));
for i = posIonLocs
    moleFractions(i) = x(i) ./ ionDensity;
end

%% Determine ion drift velocity
v = zeros(size(x, 1), numel(posIons));
for i = 1:numel(posIons)
    v(:, i) = posIons(i).mobility*x(:, TELOC)./c.lambda;
end

Ti = x(:, TGLOC) + 1./3./c.kb.*sum(moleFractions(posIonLocs).*[posIons(:).mass].*v(i).^2);

end