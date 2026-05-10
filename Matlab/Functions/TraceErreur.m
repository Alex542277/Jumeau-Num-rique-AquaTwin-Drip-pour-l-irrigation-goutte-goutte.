function TraceErreur(J,Erreur)

[X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
[r_emitter, q_irr,Efficience]=parameterGoutteur();
[Tmax,V]=TempsEtVolumeEauNecessaireIrrigation(q_irr,total_dof,J);

figure('Position',[100 100 1000 1000]);
[max_iter,tol,t]=valorsForSimulation(Tmax);

plot(t,Erreur,'LineWidth', 2);
title('Evolution de l''erreur');
xlabel('t (m)');
ylabel('Erreur relative');
grid on;

% Sauvegarde
saveas(gcf,'Erreur.png');

end