function[Teneur_en_eau_de_Van,teneur_en_eau_prim,teneur_en_eau_dual]=TraceDeLaTeneurEnEau(psi_prim,psi_dual,J)
    
    [h,r,zmax]=coordonnesPlot();
    [X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
    [r_emitter, q_irr,Efficience]=parameterGoutteur();
    [Tmax,V]=TempsEtVolumeEauNecessaireIrrigation(q_irr,total_dof,J);
    [max_iter,tol,t]=valorsForSimulation(Tmax);
    
     % Calcule de theta(teneur en eau) en fonction du temps
    [alpha_vg,n_vg, m_vg,theta_s, theta_r,k_s]=vanMualemParametersValor();
    [C, theta_func,kr_func,K_func]=VanMualemParameter(theta_s,theta_r,alpha_vg,n_vg,m_vg,k_s);
    teneur_en_eau_prim=theta_func(psi_prim);
    teneur_en_eau_dual=theta_func(psi_dual);
    Teneur_en_eau_de_Van = [teneur_en_eau_prim; teneur_en_eau_dual];
    F = scatteredInterpolant(X_all, Y_all, Teneur_en_eau_de_Van, 'natural', 'none');
    [Xplot, Yplot] = meshgrid(linspace(0, r, 150), linspace(0, zmax, 150));
    Psi_reconstructed_teneur = F(Xplot, Yplot);
    
    % Visualisation de la teneur en eau
    figure('Position', [100, 100, 800, 600]);
    surf(Xplot, Yplot, Psi_reconstructed_teneur, 'EdgeColor', 'none');
    xlabel('r (m)');
    ylabel('z (m)');
    zlabel('\theta (Teneur en eau)');
    title('Trace de la teneur en eau');
    colorbar;
    colormap(jet);
    view(45, 30);
    saveas(gcf, 'Teneur_en_eau_DDFV.png');

end