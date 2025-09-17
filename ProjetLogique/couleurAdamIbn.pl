%Couleurs choisis
couleur(vert).
couleur(jaune).
couleur(rouge).

%Coloriage du dessin
coloriage(C1, C2, C3, C4) :- couleur(C1), couleur(C2), couleur(C3), couleur(C4), C1 \== C2, C1 \== C3, C2 \== C3, C1 \== C4, C3 \== C4.
%Coloriage du dessin en mettant les tests de différence le plus tôt possible
coloriage2(C1, C2, C3, C4) :- couleur(C1), couleur(C2), C1 \== C2, couleur(C3), C1 \== C3, C2 \== C3, couleur(C4), C1 \== C4, C3 \== C4.
