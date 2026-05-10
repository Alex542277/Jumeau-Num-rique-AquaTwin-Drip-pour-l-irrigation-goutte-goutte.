function[delta,Rn,G,gamma,Tmean,VPD]=PenmanMontheithParameter()

    % delta: longueur du pas de temps en k secondes (d=0.0864 ks) 
    % Rn: rayonnement net (W.m^-2)
    % gamma:Constante psychrometrique (kPa./C^-1)
    % v:vitesse du vent 2m(m.s^-1)
    % d:longueur du pas de temps en k secondes (d=0.0864 ks)
    % e:tension de vapeur (kPa) 
    % ew:tension de vapeur saturante (kPa)
    % t:temperature moyenne quotidienne de l'air 2m (C)
    % Calcul de l'evapotranspiration journaliere:
    
    [Tmax,Tmin,RH,u2,Rs]=DataEvapotranspiration();
    Tmean = (Tmax + Tmin) / 2;

    % Pression de vapeur saturante (e_s) - Formule FAO

    e_s_Tmax = 0.6108 * exp((17.27 * Tmax) ./ (Tmax + 237.3)); 
    e_s_Tmin = 0.6108 * exp((17.27 * Tmin) ./ (Tmin + 237.3)); 
    e_s = (e_s_Tmax + e_s_Tmin) / 2;  

    % Pression de vapeur actuelle (e_a)

    e_a = (RH / 100) .* e_s;  

    % Deficit de saturation de vapeur (VPD)

    VPD = e_s - e_a; 

    % Pente de la courbe de pression de vapeur (Delta)

    delta = 4098 * e_s ./ (Tmean + 237.3).^2; 

    % Constante psychrometrique (Gamma)

    P = 101.3;  % kPa (pression standard au niveau de la mer)
    gamma = 0.000665 * P;  

    % Rayonnement net (Rn)
    % Conversion W/m^2 MJ/m^2/jour

    Rs_MJ = Rs * 0.0864; 
    alpha = 0.23;  % Albedo pour les cultures de reference
    Rns = (1 - alpha) * Rs_MJ;  % Rayonnement net ondes courtes (MJ/m^2/jour)

    % Rayonnement net ondes longues (Rnl)-approximation FAO-56

    % sigma = 4.903e-9 MJ/K^4/m^2/jour (constante de Stefan-Boltzmann)
    sigma = 4.903e-9;
    Tmean_K = Tmean + 273;  % Temperature en Kelvin

    % Pression de vapeur actuelle en kPa (e_a deja calculee)
    % Rayonnement solaire relatif (Rs/Rso)-approximation
    
    Rso = 0.75 * Rs_MJ;  % Rayonnement solaire sans nuages (approximation)
    Rs_relatif = Rs_MJ ./ Rso;
    Rs_relatif = min(Rs_relatif, 1);  % Limite 3

    % Formule FAO-56 pour Rnl

    Rnl = sigma * (Tmean_K.^4) .* (0.34 - 0.14 * sqrt(e_a)) .* (1.35 * Rs_relatif - 0.35);

    % Rayonnement net total

    Rn = Rns - Rnl;
    Rn = max(Rn, 0);  % Pour eviter les valeurs negatives

    % Evapotranspiration de reference ETo (FAO-56)

    G=0;  % Flux de chaleur du sol (neglige pour le calcul journalier)
    
end