function L_reflected = getWallReflectionsSoundLevel(X, Y, Z, dronePos, L_s, freq, buildings, pressure, temperature, humidity)
    % Function to calculate wall and ground-reflected sound levels at all meshgrid points
    L_reflected = zeros(size(X));
    reflectionCoeff = 0.5; % Reflection coefficient for walls
    groundReflectionCoeff = 0.7; % Reflection coefficient for ground
    
    % Loop through each building
    for j = 1:size(buildings, 1)
        x1 = buildings(j, 1);
        y1 = buildings(j, 2);
        z1 = buildings(j, 3);
        x2 = buildings(j, 4);
        y2 = buildings(j, 5);
        z2 = buildings(j, 6);
        
        % Compute virtual source for reflections
        x_v = 2 * x1 - dronePos(1);
        y_v = 2 * y1 - dronePos(2);
        z_v = 2 * z1 - dronePos(3);
        
        % Calculate reflected path length
        r_reflected = sqrt((X - x_v).^2 + (Y - y_v).^2 + (Z - z_v).^2);
        r_reflected = max(r_reflected, 1); % Avoid singularity
        
        % Compute reflected sound level
        L_geom_reflected = getGeometricSpreadingSoundLevel(L_s, r_reflected);
        L_air_reflected = getAirAbsorptionSoundLevel(freq, r_reflected, pressure, temperature, humidity);
        
        % Combine reflected contributions
        L_reflected = 10 * log10(10.^(L_reflected / 10) + 10.^(reflectionCoeff * (L_geom_reflected + L_air_reflected) / 10));
    end
    
    % Ground reflection if there are no buildings directly below the drone
    for i = 1:numel(X)
        in_building = any(X(i) >= buildings(:, 1) & X(i) <= buildings(:, 4) & ...
                          Y(i) >= buildings(:, 2) & Y(i) <= buildings(:, 5));
        
        if ~in_building
            z_v_ground = -Z(i);
            r_ground = sqrt(X(i)^2 + Y(i)^2 + (Z(i) - z_v_ground)^2);
            r_ground = max(r_ground, 1);
            
            L_geom_ground = getGeometricSpreadingSoundLevel(L_s, r_ground);
            L_air_ground = getAirAbsorptionSoundLevel(freq, r_ground, pressure, temperature, humidity);
            
            L_reflected(i) = 10 * log10(10.^(L_reflected(i) / 10) + 10.^(groundReflectionCoeff * (L_geom_ground + L_air_ground) / 10));
        end
    end
end
