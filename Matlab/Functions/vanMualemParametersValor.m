function [alpha_vg,n_vg, m_vg,theta_s, theta_r,k_s]=vanMualemParametersValor()

    % Parametres de van Genuchten

    alpha_vg = 7.5;      % parametre alpha (m^-1)
    n_vg = 1.89;          % parametre n
    m_vg = 1-1/n_vg;      % parametre m
    theta_s = 0.41;       % teneur en eau de saturation (m^3/m^3)
    theta_r = 0.065;      % teneur en eau residuelle (m^3/m^3)
    k_s = 1.23*10^(-4);  

end