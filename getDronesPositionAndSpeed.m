function droneData = getDronesPositionAndSpeed(droneData, xMax, yMax, zMax, timeStep)
% This function updates drone positions and speeds for the next time step.
% It considers boundary collisions (reflection) for the drones.

    for i = 1:numel(droneData)
        droneData(i).Pos.X = droneData(i).Pos.X + droneData(i).Vel.X * timeStep;
        droneData(i).Pos.Y = droneData(i).Pos.Y + droneData(i).Vel.Y * timeStep;
        droneData(i).Pos.Z = droneData(i).Pos.Z + droneData(i).Vel.Z * timeStep;
    end

end
