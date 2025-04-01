function L_geom= getGeometricSpreadingSoundLevel(L_s,r)
%This function returns value of geometric spreading sound level
%  L_s - source sound level [dB]
%  r - distance to observer matrix [m], r>1
L_geom = L_s - (20 * log10(r)+11);
end