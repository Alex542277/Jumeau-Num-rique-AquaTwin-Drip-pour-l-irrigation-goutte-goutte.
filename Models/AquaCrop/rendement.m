function B=rendement(T)
    % T: nombre de jours de periode de croissance
    Tr=0;
    for i=1:T
        ETo=CalculEvapotranspirationJournaliere(i);
        Tpot=TranspirationPotentielle(ETo);
        Tr=Tr+Tpot/ETo;
    end
    [WP,Hi]=parameterAquaCrop();
    B=WP*Tr;

end