function [psi_omega,psi_c,psi_h,ro,A,d_r,phi]=parametresSource(total_dof)
    
    psi_omega=ones(total_dof, 1);% Saturation
    psi_c=ones(total_dof, 1);% arret de transpiration
    psi_h=ones(total_dof, 1);% Debut de stress
    psi_omega(:,1)=0.2; 
    psi_c(:,1)=-1.2;
    psi_h(:,1)=-0.5;
    d_r=0.008;  % espacement inter-rang
    dl=0.03;   % espacement interligne
    A=d_r*dl; % Surface correspondant a une plante
    phi = @(t) -sin(t-2*pi); % 0 la nuit
    ro = @(r,z)1/A;

end