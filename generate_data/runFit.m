% Params
theta = 33;
phi = 78;
vel = 370000;
base = 5.4;
thresh = 0.15;

% Calculate map here
map = csvread('out_grid.csv');
map = reshape(map, [361 181])';
map = map(1:180, 1:360);

% Calculate mask here
mask = ones(180, 360);
mask(1:50, 1:360) = zeros(50, 360);
mask(131:180, 1:360) = zeros(50, 360);
mask(map/max(max(map)) > thresh) = 0;
    
mapRed = map;
mapRed(mapRed == 0) = [];
stdev = sqrt(var(mapRed));

% Get error
optimFn = @(x) calcFitError(map, x(1), x(2), x(3), base, mask);
[x, fval] = fminsearch(optimFn, [theta, phi, vel]);

chiSq = fval/stdev;
disp(strcat('Chi Squared=', num2str(chiSq)));