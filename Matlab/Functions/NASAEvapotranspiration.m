%% NASA Evapotranspiration 

% Lecture des donnees
data = readtable('DonneesPourEvapotranspiration.csv');
[Tmax,Tmin,RH,u2,Rs]=DataEvapotranspiration();

% Temperature moyenne
Tmean = (Tmax + Tmin) / 2;

% 1. Pression de vapeur saturante (e_s) - Formule FAO
e_s_Tmax = 0.6108 * exp((17.27 * Tmax) ./ (Tmax + 237.3));  
e_s_Tmin = 0.6108 * exp((17.27 * Tmin) ./ (Tmin + 237.3));  
e_s = (e_s_Tmax + e_s_Tmin) / 2;  

% Pression de vapeur actuelle (e_a)
e_a = (RH / 100) .* e_s;  

% Deficit de saturation de vapeur (VPD)
VPD = e_s - e_a; 

% Pente de la courbe de pression de vapeur (Delta)
Delta = 4098 * e_s ./ (Tmean + 237.3).^2; 

% Constante psychrometrique (Gamma)
P = 101.3;  % kPa (pression standard au niveau de la mer)
Gamma = 0.000665 * P;  

% Rayonnement net (Rn)
% Conversion W/m^2  MJ/m^2/jour
Rs_MJ = Rs * 0.0864; 
alpha = 0.23;  % Albedo pour les cultures de reference
Rns = (1 - alpha) * Rs_MJ;  % Rayonnement net ondes courtes (MJ/m^2/jour)

% Rayonnement net ondes longues (Rnl) - approximation FAO-56

% sigma = 4.903e-9 MJ/K^4/m^2/jour (constante de Stefan-Boltzmann)
sigma = 4.903e-9;
Tmean_K = Tmean + 273;  % Temperature en Kelvin

% Pression de vapeur actuelle en kPa (e_a deja calculee)
% Rayonnement solaire relatif (Rs/Rso) - approximation
Rso = 0.75 * Rs_MJ;  % Rayonnement solaire sans nuages (approximation)
Rs_relatif = Rs_MJ ./ Rso;
Rs_relatif = min(Rs_relatif, 1);  % Limitez 1

% Formule FAO-56 pour Rnl

Rnl = sigma * (Tmean_K.^4) .* (0.34 - 0.14 * sqrt(e_a)) .* (1.35 * Rs_relatif - 0.35);

% Rayonnement net total

Rn = Rns - Rnl;
Rn = max(Rn, 0);  % Eviter les valeurs negatives

% Evapotranspiration de reference ETo (FAO-56)

G = 0;  % Flux de chaleur du sol (neglige pour le calcul journalier)

numerateur = 0.408 * Delta .* (Rn - G) + Gamma .* (900 ./ (Tmean + 273)) .* u2 .* VPD;
denominateur = Delta + Gamma .* (1 + 0.34 .* u2);

ETo = numerateur ./ denominateur;
ETo = max(ETo, 0);  % Pour eviter les valeurs negatives

data.ETo=ETo;

