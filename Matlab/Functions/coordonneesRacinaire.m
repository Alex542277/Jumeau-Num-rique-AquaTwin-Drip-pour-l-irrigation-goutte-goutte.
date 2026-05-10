function [dr,dz,ri,zi,zr,R]=coordonneesRacinaire(r,zmax,total_dof)

    dr = r/total_dof;
    dz = zmax/total_dof;
    ri = 0:dr:r;
    zi = 0:dz:zmax;
    R = r;
    zr=0.4; % Profondeur racinaire


end