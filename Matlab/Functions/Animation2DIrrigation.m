function Animation2DIrrigation(psi_solution, J)
% Animation montrant la progression de l'eau dans le sol
    
    [h,r,zmax]=coordonnesPlot();
    [X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
    [r_emitter, q_irr,Efficience]=parameterGoutteur();
    [Tmax,V]=TempsEtVolumeEauNecessaireIrrigation(q_irr,total_dof,J);
    [max_iter,tol,t]=valorsForSimulation(Tmax);
    [alpha_vg,n_vg,m_vg,theta_s,theta_r,k_s]=vanMualemParametersValor();
    [C, theta_func,kr_func,K_func]=VanMualemParameter(theta_s,theta_r,alpha_vg,n_vg,m_vg,k_s);
    
    % Grille d'interpolation
    r_max = max(X_all);
    z_max = max(Y_all);
    [Xplot, Yplot] = meshgrid(linspace(0, z_max, 100), linspace(0, r_max, 100));
    
    % Creation de la figure
    figure('Position', [120, 120, 1000, 1000]);
    colormap(jet);
    
    n_frames = size(psi_solution, 1);
    indices = 1:max(1, round(n_frames/50)):n_frames;
    
    % Nom du fichier GIF
    gif_filename = 'Animation_Irrigation.gif';
    
    for k = 1:length(indices)
        nt = indices(k);
        
        % Recuperation de la solution au temps nt
        psi_solution_ = psi_solution(nt,:)';
        psi_prim = psi_solution_(1:n_prim);
        psi_dual = psi_solution_(n_prim+1:end);
        
        % Calcul de la teneur en eau
        teneur_prim = theta_func(psi_prim);
        teneur_dual = theta_func(psi_dual);
        Teneur_eau = [teneur_prim; teneur_dual];
        
        % Interpolation
        F = scatteredInterpolant(X_all, Y_all, Teneur_eau, 'natural', 'linear');
        Teneur_interp = F(Xplot, Yplot);
        
        % Effacement et redessinage
        clf;
        
        % Affichage
        contourf(Yplot, Xplot, Teneur_interp, 80, 'LineColor', 'none');
        colormap(jet);
        colorbar;
        caxis([theta_r, theta_s]);
        
        xlabel('r (m)');
        ylabel('z (m)');
        xlim([0, r_max]);
        ylim([0, z_max]);
        
        set(gca, 'YDir', 'reverse');
        
        hold on;
        scatter(-1.8*r_emitter+h, 0, 400, 'filled', 'r');
        plot([0, r_max], [0, 0], 'k-', 'LineWidth', 1.5);
        hold off;
        
        title(sprintf('Drip Irrigation: t = %.5f s', t(nt)/60));
        axis equal tight;
        
        drawnow;
        
        % Capture de la frame pour le GIF
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        
        % Ecriture du GIF
        if k == 1
            imwrite(imind, cm, gif_filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
        else
            imwrite(imind, cm, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        end
        
        fprintf('Frame %d/%d sauvegardee\n', k, length(indices));
    end
    
    fprintf('Animation sauvegardee : %s\n', gif_filename);
end