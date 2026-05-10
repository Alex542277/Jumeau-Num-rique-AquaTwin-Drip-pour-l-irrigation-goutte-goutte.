function[SH,Pt]=StresseHydriqueEtPotentielHydrique(Theta_root,J)

    [Hcc,RU,p_s,theta_actuel]=Solfeatures();
    [X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
    [r_emitter, q_irr,Efficience]=parameterGoutteur();
    [Tmax,V]=TempsEtVolumeEauNecessaireIrrigation(q_irr,total_dof,J);
    [max_iter,tol,t]=valorsForSimulation(Tmax);

    % Calculons maintenant le stress hydrique:
    
    SH_=(Hcc-Theta_root)/RU ;
    figure()
    plot(t,SH_,'LineWidth', 2);
    xlabel('Temps');
    ylabel('Ks');
    title('Stress hydrique');
    grid on;

    % Potentiel Hydrique du sol:
    % Potentiel Hydrique critique de la plante:
    % Relation entre potentiel hydrique du sol et Humidite: phi_s=a*H^b+c:
    
    SH=SH_;
    phi_s=modeleRawlsSaxton();
    Pt=phi_s(Theta_root);
    figure()
    plot(t,Pt,'LineWidth', 2);
    xlabel('Temps');
    ylabel('Ks');
    title('Potentiel hydrique');
    grid on;
    
    if max(Pt)>=p_s
        fprintf('Stress hydrique eleve')
    end

end