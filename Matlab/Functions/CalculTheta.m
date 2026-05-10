function psi_sol=CalculTheta(theta)

    %% Parametres du sol(sablo-limoneux)
    [alpha_vg,n_vg, m_vg,theta_s, theta_r,k_s]=vanMualemParametersValor();
   
    %% Saturation effective
    Se = (theta - theta_r) / (theta_s - theta_r);

    %% Verification
    if Se <= 0 || Se >= 1
        error('Se doit etre entre 0 et 1');
    end

    %% Calcul de psi (en metres)
    psi_sol= - ( (Se^(-1/m_vg) - 1)^(1/n_vg) ) / alpha_vg;


end