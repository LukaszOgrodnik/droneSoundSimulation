function L_dop = getDopplerEffectSoundLevel(freq,r,x_d,y_d,z_d,X,Y,Z,speedOfSound,velocity)
    % Doppler effect

    relativeVelocity = ((X - x_d) * velocity(1) + (Y - y_d) * velocity(2) + (Z - z_d) * velocity(3)) ./ r;
    dopplerShift = freq * (speedOfSound ./ (speedOfSound - relativeVelocity));
    freqFactor = dopplerShift / freq; % Frequency scaling factor

    L_dop = 10 * log10(freqFactor);
end

