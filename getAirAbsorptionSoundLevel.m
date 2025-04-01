function L_air = getAirAbsorptionSoundLevel(frequency,r,pressure,temperature,humidity)
%This function returns air absorption sound level
%   Detailed explanation goes here

    % Convert temperature to Kelvin
    temperatureK = temperature + 273.15;

    % Constants for air absorption calculation
    T0 = 293.15; % Reference temperature in Kelvin
    P0 = 101325; % Reference pressure in Pa
    

    % Saturation vapor pressure
    Psat = 10^(-6.8346 * (273.16 / temperatureK)^1.261 + 4.6151);

    % Mole fraction of water vapor
    h = humidity * Psat / pressure;

    % Relaxation frequencies
    frO = pressure / P0 * (24 + 4.04e4 * h * (0.02 + h) / (0.391 + h));
    frN = pressure / P0 * (T0 / temperatureK)^0.5 * (9 + 280 * h * exp(-4.17 * ((temperatureK / T0)^(-1/3) - 1)));

    % Absorption coefficient calculation
    absorption_coefficient = 8.686 * frequency^2 * ((1.84e-11 * (pressure / P0)^-1 * (temperatureK / T0)^0.5) + ...
    (temperatureK / T0)^-2.5 * (0.01275 * exp(-2239.1 / temperatureK) * (frO+(frequency^2/frO))^(-1)+0.1068*exp(-3352/temperatureK)*(frN+frequency^2/frN)^(-1)));

    L_air = -absorption_coefficient * r;
end


