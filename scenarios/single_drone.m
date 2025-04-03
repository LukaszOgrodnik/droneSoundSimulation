clc; clear; close all;

% === SIMULATION PARAMETERS ===
numDrones = 1;% Total number of drones )
gridSize = 50;               % Adjusted grid size for a road length of 500m
xMax = 50;                   % Maximum X-coordinate (500 meters for road length)
yMax = 50;                    % Maximum Y-coordinate (10m building, 2m siewalk, 10m  lane, 4m gap, 10m lane , 2m sidewalk, 10m building)
zMax = 50;                   % Maximum Z-coordinate (for drones at 100 meters)
freq = 1000;                  % Base frequency of drone sound (Hz)

temperature = 20;    % Temperature in Celsius
humidity = 100;      % Relative humidity in percentage
pressure = 101325;   % Atmospheric pressure in Pa

speedOfSound = 343;  % Speed of sound in air (m/s)
timeStep = 1;        % Time step for simulation (seconds)
totalTime = 50;      % Total simulation time (seconds)
numTimeSteps = totalTime / timeStep + 1;  % Number of timesteps

% === DEFINE DRONE FAMILIES ===
droneFamilies = struct(...
    'Taxi', struct('fraction', 0.2, 'soundLevel', 90), ...
    'Delivery', struct('fraction', 0.3, 'soundLevel', 80), ...
    'Recreational', struct('fraction', 0.5, 'soundLevel', 70));

% === COMPUTE NUMBER OF DRONES PER FAMILY ===
droneTypes = fieldnames(droneFamilies);
numDronesPerType = struct();

for i = 1:numel(droneTypes)
    type = droneTypes{i};
    numDronesPerType.(type) = round(numDrones * droneFamilies.(type).fraction);
end

% Adjust last category to ensure total sum equals numDrones
numDronesPerType.Recreational = numDrones - (numDronesPerType.Taxi + numDronesPerType.Delivery);

% === INITIALIZE DRONE DATA ===
droneData(numDrones) = struct('Type', '', 'SoundLevel', 0, 'Pos', zeros([1,3]),'Vel', zeros([1,3]));

% --- Subgroup 1: Recreational Drones ---
droneData(1).Type = 'Recreational';
droneData(1).SoundLevel = droneFamilies.Recreational.soundLevel;
droneData(1).Pos = [0,yMax/2,30]; % X, Y, Z positions
droneData(1).Vel = [1, 0, 0]; % Moving at 1 m/s along X





% === BUILDING DEFINITION (3D BOUNDING BOX) WITH GAPS FOR CROSSINGS ===
% Define buildings as [xmin, ymin, zmin, xmax, ymax, zmax]
buildings = [
];


% === CREATE 3D GRID ===
x = linspace(0, xMax, gridSize);
y = linspace(0, yMax, gridSize);
z = linspace(0, zMax, gridSize);
[X, Y, Z] = meshgrid(x, y, z);

%%  === PLOTTING THE SIMULATION DATA ===
% Plot buildings
figure;
hold on;
for i = 1:size(buildings, 1)
    % Plot each building (as a rectangle in 3D)
    fill3([buildings(i, 1), buildings(i, 1), buildings(i, 4), buildings(i, 4)], ...
          [buildings(i, 2), buildings(i, 5), buildings(i, 5), buildings(i, 2)], ...
          [buildings(i, 3), buildings(i, 3), buildings(i, 6), buildings(i, 6)], 'k');
end

% Plot drone positions
% Recreational Drones
for i = 1:1
    plot3(droneData(i).Pos(1), droneData(i).Pos(2), droneData(i).Pos(3), 'go', 'MarkerFaceColor', 'g');
end

% Labeling
xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
title('Initial Positions of Drones and Buildings');
grid on;
axis([0 xMax 0 yMax 0 zMax]);
view(3);
hold off;

