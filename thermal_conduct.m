function kappa = thermal_conduct(particle,argon,a,c)

avgMass = (particle.mass+argon.mass)/2;
avgSigmaLJ = (particle.sigma+argon.sigma)/2;

kappa = 25/34*3/2*c.kb*((particle.mass+avgMass)*pi*c.kb*a.Tg/(2*particle.mass*avgMass))^.5...
    /(pi*avgSigmaLJ^2);

end