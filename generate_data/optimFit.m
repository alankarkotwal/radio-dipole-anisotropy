% Calculate map here
map = csvread('out_grid.csv');
map = reshape(map, [361 181])';
map = map(1:180, 1:360);

% Calculate mask here
mask = ones(180, 360);
mask(1:50, 1:360) = zeros(50, 360);
mask(131:180, 1:360) = zeros(50, 360);
mask(map/max(max(map)) > thresh) = 0;

chis = zeros(100, 1);
thetas = zeros(100, 1);
phis = zeros(100, 1);
vels = zeros(100, 1);
bases = zeros(100, 1);

for i = 1:100
    
    thetas(i) = randi(181)-1;
    phis(i) = randi(361)-1;
    vels(i) = 1000*randi([100, 10000]);
    bases(i) = 5.4;
    thresh = 0.15;

    % Get error
    [chiSq, calcMap] = calcFitError(map, thetas(i), phis(i), vels(i), bases(i), mask);
    chis(i) = chiSq;
    
    disp([thetas(i) phis(i) vels(i) bases(i) chiSq]);
    
end