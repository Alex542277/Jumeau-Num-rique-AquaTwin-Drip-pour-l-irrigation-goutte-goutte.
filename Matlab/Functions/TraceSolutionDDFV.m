function[Psi_all,psi_prim,psi_dual]=TraceSolutionDDFV(Psi_solution,J)

[h,r,zmax]=coordonnesPlot();
[X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
[r_emitter, q_irr,Efficience]=parameterGoutteur();
[Tmax,V]=TempsEtVolumeEauNecessaireIrrigation(q_irr,total_dof,J);
[max_iter,tol,t]=valorsForSimulation(Tmax);

% Reconstruction DDFV 
 psi_solution=Psi_solution(length(t),:)';
 
% Extraction des solutions
 psi_prim = psi_solution(1:n_prim);
 psi_dual = psi_solution(n_prim+1:end);
 Psi_all = [psi_prim; psi_dual];

% Grille fine pour visualisation
[Xplot, Yplot] = meshgrid(linspace(0, r, 150), linspace(0, zmax, 150));

% Reconstruction DDFV 
F = scatteredInterpolant(X_all, Y_all, Psi_all, 'natural', 'none');
Psi_reconstructed = F(Xplot, Yplot);

% Visualisation
figure('Position', [100, 100, 800, 600]);
surf(Xplot, Yplot, Psi_reconstructed, 'EdgeColor', 'none');
xlabel('r (m)');
ylabel('z (m)');
zlabel('\psi (pression)');
title('Reconstruction de la solution');
colorbar;
colormap(jet);
view(45, 30);
saveas(gcf, 'Richards_DDFV.png');

end