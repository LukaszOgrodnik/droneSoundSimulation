clc; clear; close all;

% === SIMULATION PARAMETERS ===
numDrones = 5 + 6 + 2;% Total number of drones )
gridSize = 50;               % Adjusted grid size for a road length of 500m
xMax = 500;                   % Maximum X-coordinate (500 meters for road length)
yMax = 48;                    % Maximum Y-coordinate (10m building, 2m siewalk, 10m  lane, 4m gap, 10m lane , 2m sidewalk, 10m building)
zMax = 120;                   % Maximum Z-coordinate (for drones at 100 meters)
freq = 1000;                  % Base frequency of drone sound (Hz)

temperature = 20;    % Temperature in Celsius
humidity = 100;      % Relative humidity in percentage
pressure = 101325;   % Atmospheric pressure in Pa

speedOfSound = 343;  % Speed of sound in air (m/s)
timeStep = 1;        % Time step for simulation (seconds)
totalTime = 60;      % Total simulation time (seconds)
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
index = 1;
for i = 1:6
    % Positioning drones every 5 meters in X, and every 3 meters in Y for Recreational drones
    droneData(index).Type = 'Recreational';
    droneData(index).SoundLevel = droneFamilies.Recreational.soundLevel;
    droneData(index).Pos = [3 * floor((i-1)/3), 5 * (mod(i-1, 3))+12, 20]; % X, Y, Z positions
    droneData(index).Vel = [1, 0, 0]; % Moving at 1 m/s along X
    index = index + 1;
end

% --- Subgroup 2: Delivery Drones ---
for i = 1:6
    % Spaced evenly on XY plane at Z = 40
    droneData(index).Type = 'Delivery';
    droneData(index).SoundLevel = droneFamilies.Delivery.soundLevel;
    droneData(index).Pos = [25 + mod(i-1, 6) * 25, 10 * floor((i-1)/6)+12, 40]; % Spaced in XY
    droneData(index).Vel = [5, 0, 0]; % Moving at 5 m/s along X
    index = index + 1;
end

% --- Subgroup 3: Taxi Drones ---
for i = 1:2
    % Moving in the middle of the lane at X = 10 or 30, spaced 20 meters apart
    droneData(index).Type = 'Taxi';
    droneData(index).SoundLevel = droneFamilies.Taxi.soundLevel;
    if mod(i, 2) == 1
        droneData(index).Pos = [10, 17, 100]; % Lane 1
    else
        droneData(index).Pos = [30, 17, 100]; % Lane 2
    end
    droneData(index).Vel = [10, 0, 0]; % Moving at 10 m/s along X
    index = index + 1;
end


% === BUILDING DEFINITION (3D BOUNDING BOX) WITH GAPS FOR CROSSINGS ===
% Define buildings as [xmin, ymin, zmin, xmax, ymax, zmax]
buildings = [
    0,   0,  0,  100,  10,  10;
    110,   0,  0,  210,  10,  10;
    220,   0,  0,  320,  10,  10;
    330, 0,0,400,10,10;
      0,   yMax-10,  0,  100,  yMax,  10;
    110,   yMax-10,  0,  210,  yMax,  10;
    220,   yMax-10,  0,  320,  yMax,  10;
    330, yMax-10,0,400,yMax,10;
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
for i = 1:6
    plot3(droneData(i).Pos(1), droneData(i).Pos(2), droneData(i).Pos(3), 'go', 'MarkerFaceColor', 'g');
end
% Delivery Drones
for i = 7:13
    plot3(droneData(i).Pos(1), droneData(i).Pos(2), droneData(i).Pos(3), 'bo', 'MarkerFaceColor', 'b');
end
% Taxi Drones
for i = 13:14
    plot3(droneData(i).Pos(1), droneData(i).Pos(2), droneData(i).Pos(3), 'ro', 'MarkerFaceColor', 'r');
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

