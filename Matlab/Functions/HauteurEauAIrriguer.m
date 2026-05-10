function Hauteur=HauteurEauAIrriguer(total_dof)
    
    [h,r,zmax]=coordonnesPlot();
    [Hcc,RU,p_s,theta_actuel]=Solfeatures();
    [r_emitter, q_irr,Efficience]=parameterGoutteur();
    [dr,dz,ri,zi,zr,R]=coordonneesRacinaire(r,zmax,total_dof);
     Hauteur=abs((Hcc-theta_actuel))*zr/Efficience;
     



end