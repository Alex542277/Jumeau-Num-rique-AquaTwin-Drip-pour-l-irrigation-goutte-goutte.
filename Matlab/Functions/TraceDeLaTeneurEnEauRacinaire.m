function Theta_root=TraceDeLaTeneurEnEauRacinaire(Psi_solution,J)

[X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
[r_emitter, q_irr,Efficience]=parameterGoutteur();
[Tmax,V]=TempsEtVolumeEauNecessaireIrrigation(q_irr,total_dof,J);
[max_iter,tol,t]=valorsForSimulation(Tmax);
[h,r,zmax]=coordonnesPlot();
[alpha_vg,n_vg, m_vg,theta_s, theta_r,k_s]=vanMualemParametersValor();
[Capacite_hydrique, theta_func,kr_func,K_func]=VanMualemParameter(theta_s,theta_r,alpha_vg,n_vg,m_vg,k_s);
[X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
[dr,dz,ri,zi,zr,R]=coordonneesRacinaire(r,zmax,total_dof);
Theta = theta_func(Psi_solution);
Theta_root = zeros(length(zi),1);

for i = 1:length(zi)

    theta_mean = 0;   % RESET OBLIGATOIRE

    for j = 1:length(ri)-1
        theta_mean = theta_mean + Theta(i,j) * ri(j) * dr * dz;
    end

    theta_root = (2/(R^2 * zr)) * theta_mean;
    Theta_root(i) = theta_root;

end


figure;
plot(t, Theta_root, 'LineWidth', 2);
xlabel('Temps');
ylabel('\theta_{root}');
title('Teneur en eau moyenne racinaire');
grid on;

end