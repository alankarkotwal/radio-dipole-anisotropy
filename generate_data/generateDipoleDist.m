function [map, lat, lon] = generateDipoleDist(theta, phi, vel, sourceCountExp, spectralIdx)

    % Generate a distribution of radio sources with parameters co-latitude
    % theta and longitude phi.
    
    % Create the dipole and normlize it
    myDip = SHCreateYVec(2, phi, theta, 'deg');
    [map, lon, lat] = SHMapToGrid(myDip, 10);
    
    % Visualise the resulting map
    delta = 2*vel*(2+sourceCountExp*(1+spectralIdx))/300000000;
    map = delta * map/max(max(map));
    pcolor(lon, lat, map); shading interp; cb=colorbar;

end