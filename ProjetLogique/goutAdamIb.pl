%Profils des personnes
personne(lucas, têtenlaire, 1.3, brun, 13).
personne(max, ladétente, 1.5, noir, 14).
personne(barry, vatrovite, 1.2, roux, 12).
personne(caroline, lasauvage, 1.3, brun, 13).
personne(ambre, lechacal, 1.2, roux, 12).
personne(anna, ladebrouille, 1.5, noir, 14).
personne(gus, lebizarre, 1.4, blanc, 12).

%Gouts personnels des personnes
gout(lucas, pop, science-fiction, jeux).
gout(max, jazz, policier, jeux).
gout(barry, rock, bd, jeux).
gout(caroline, rock, bd, jeux).
gout(ambre, jazz, policier, jeux).
gout(anna, pop, science-fiction, jeux).
gout(gus, cacophonie, fantastique, inconnu).

%Profils que les gens recherchent
recherche(lucas, 1.5, noir, 14).
recherche(max, 1.2, roux, 12).
recherche(barry, 1.3, brun, 13).
recherche(caroline, 1.2, roux, 12).
recherche(ambre, 1.5, noir, 14).
recherche(anna, 1.3, brun, 13).
recherche(gus, 3.0, multicolore, 16).

% X convient à Y si X a les caractéristiques T, C, A que Y recherche.
convient-physiquement(X, Y) :- X \== Y, personne(X, _, T, C, A), recherche(Y, T, C, A).

% X et Y ont les mêmes goûts s'ils partagent les mêmes caractéristiques M, L et S.
ont-memes-gouts(X, Y) :- X \== Y, gout(X, M, L, S), gout(Y, M, L, S).

% X et Y sont assortis si X et Y se conviennent l'un l'autre et s'ils partagent les mêmes goûts.
assortis(X, Y) :- X \== Y, convient-physiquement(X, Y), convient-physiquement(Y, X), ont-memes-gouts(X, Y).
