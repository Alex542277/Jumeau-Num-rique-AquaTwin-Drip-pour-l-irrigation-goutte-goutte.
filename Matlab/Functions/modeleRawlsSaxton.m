function phi_s=modeleRawlsSaxton()

    % modele de Rawls et Saxton
    a = 0.02;
    b = 0.4;
    c = 0.08;
    phi_s=@(H) a*H.^(b)+c;
    
end