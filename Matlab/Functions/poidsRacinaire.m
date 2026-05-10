function w=poidsRacinaire()

[X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
[h,r,zmax]=coordonnesPlot();
[dr,dz,ri,zi,zr,R]=coordonneesRacinaire(r,zmax,total_dof);

% poids racinaire
alpha=2;
w=exp(-alpha * zi);
w(zi > zmax) = 0;
w=w/sum(w);

end