function [map, lat, lon] = generateDipoleDist(theta, phi, vel, sourceCountExp, spectralIdx, baseline, res)

    % Generate a distribution of radio sources with parameters co-latitude
    % theta and longitude phi, moveing with velocity vel. Usually, 
    % sourceCountExp ~ 1, spectralIdx ~ 0.75. Baseline is the baseline 
    % source density.
    
    % Create the dipole
    myDip = SHCreateYVec(2, phi, theta, 'deg');
    [map, lon, lat] = SHMapToGrid(myDip, res);
    
    % Get fluctuation level
    delta = 2*vel*(2+sourceCountExp*(1+spectralIdx))/300000000;
    
    % Delta is the total fractional fluctuation in surface density from
    % maximum to minimum. Map the dipole values to baseline(1-delta/2) 
    % to baseline(1+delta/2)
    maxIn = max(max(map));
    minIn = min(min(map));
    maxOut = baseline*(1+delta/2);
    minOut = baseline*(1-delta/2);
    
    a = polyfit([minIn, maxIn], [minOut, maxOut], 1);
    map = a(1)*map + a(2);
    
    % Visualise the resulting map
    %pcolor(lon, lat, map); shading interp; cb=colorbar;

end