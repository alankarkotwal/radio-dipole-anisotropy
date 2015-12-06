function out = calcFitError(map, theta, phi, vel, base, mask)

    % Map: Given binned source counts. Expected 180x360
    % Theta, Phi, Vel, Base: Model parameters
    % Mask: Exclusion parameters. Expected to be the same size as Map.
    myMap = generateDipoleDist(theta, phi, vel, 1, 0.75, base, 1);
	
    %mapRed = map;
    %mapRed(mapRed == 0) = [];
    %stdev = sqrt(var(mapRed));
    
    err = sum(sum((mask .* (map - myMap)).^2));
    %out = sqrt(err/nnz(mask))/stdev;
    out = sqrt(err/nnz(mask));

end