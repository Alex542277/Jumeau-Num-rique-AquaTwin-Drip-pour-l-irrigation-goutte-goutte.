function[Tmax,Tmin,RH,u2,Rs]=DataEvapotranspiration()

% Lecture des donnees
data = readtable('DonneesPourEvapotranspiration.csv');

% Extraction des variables disponibles

Tmax = data.T2M_MAX;      % Temperature max (C)
Tmin = data.T2M_MIN;      % Temperature min (C)
RH   = data.RH2M;         % Humidite relative moyenne (%)
u2   = data.WS2M;         % Vitesse du vent (m/s)
Rs   = data.ALLSKY_SFC_SW_DWN;  % Rayonnement solaire (W/m^2)

end