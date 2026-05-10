function psi_old=InitialSolution()
theta=thetaInitial();
[X_all,Y_all,Xp,Yp,n_prim,n_dual,total_dof]=MeshGrid();
psi_sol=CalculTheta(theta);
psi_old =zeros(total_dof, 1);
psi_old(:,1)=psi_sol;

end