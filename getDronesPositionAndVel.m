function droneData = getDronesPositionAndVel(droneData,timeStep)
% This function updates drone positions and speeds for the next time step.


    for i = 1:numel(droneData)
        droneData(i).Pos= droneData(i).Pos+ droneData(i).Vel * timeStep;
    end

end
