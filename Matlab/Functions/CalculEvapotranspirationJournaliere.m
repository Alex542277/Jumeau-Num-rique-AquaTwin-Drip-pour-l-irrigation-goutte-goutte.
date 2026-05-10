function ETo=CalculEvapotranspirationJournaliere(t)
[delta,Rn,G,gamma,Tmean,VPD]=PenmanMontheithParameter();

% Calcul de l'Evapotranspiration journaliere:
[Tmax,Tmin,RH,u2,Rs]=DataEvapotranspiration();
numerateur = 0.408 * delta .* (Rn-G) + gamma .* (900 ./ (Tmean + 273)) .* u2 .* VPD;
denominateur = delta + gamma.* (1 + 0.34 .* u2);
ETo = numerateur ./ denominateur;
ETo = max(ETo, 0);  %  Pour eviter les valeurs negatives
ETo = ETo(t); 

end