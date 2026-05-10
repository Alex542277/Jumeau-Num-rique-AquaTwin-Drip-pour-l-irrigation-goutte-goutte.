function [T,V]=TempsEtVolumeEauNecessaireIrrigation(q_irr,total_dof,t)

    [X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
    [psi_omega,psi_c,psi_h,ro,Aire,d_r,phi]=parametresSource(total_dof);
    H=HauteurEauAIrriguer(total_dof);
    T=(10^(-3))*H*Aire/q_irr;
    Vt=q_irr*T;
    ETo=CalculEvapotranspirationJournaliere(t);
    Tpot=TranspirationPotentielle(ETo);
    ETr=EvapotranspirationRelle(Tpot,ETo);
    if (Vt>ETr)
        V=Vt;
        
    else
        V=ETr;
    end
    
end