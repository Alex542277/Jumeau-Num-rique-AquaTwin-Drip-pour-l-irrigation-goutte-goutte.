%% Implementation du systeme couple sol-culture:
clear all; clc;

%Jour Julien:
J=200;

% Initialisation
psi_old =InitialSolution();

% Resolution de l'equation de RicharD par la DDFV
[Psi_solution, Erreur]=DDFVRichardIrrigation(psi_old,J);

% Trace de la solution(Le potentiel matriciel)
[Psi_all,psi_prim,psi_dual]=TraceSolutionDDFV(Psi_solution,J);

% Trace de la teneur en eau(theta)
[Teneur_en_eau_de_Van,teneur_en_eau_prim,teneur_en_eau_dual]=TraceDeLaTeneurEnEau(psi_prim,psi_dual,J);

% Evolution de la teneur en eau racinaire au cours du temps:
Theta_root=TraceDeLaTeneurEnEauRacinaire(Psi_solution,J);

% Evolution du stress hydrique et du potentiel hydrique au cours du temps:
[SH,Pt]=StresseHydriqueEtPotentielHydrique(Theta_root,J);

% Evolution de la solution au cours du temps(carte 2D)et simulation en
% temps reel
Trace2D(Psi_solution,J);
Trace2DFin(Psi_solution,J);
Trace2DFinDI(Psi_solution,J);
TraceErreur(J,Erreur);
Animation2DIrrigation(Psi_solution,J);


% Calcul du rendement et recolte:
[B,R]=AquaCropSimulation(SH);






