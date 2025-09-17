%Sommets du graphe
sommet(a).
sommet(b).
sommet(c).
sommet(d).
sommet(e).
sommet(f).

%Arêtes du graphe
arete(a, b).
arete(b, d).
arete(b, c).
arete(a, c).
arete(e, f).

% Il y a un chemin orienté de X à Y s'il y a une ou plusieurs arêtes les reliant dans l'ordre.
chemin_orienté(X, Y) :- arete(X, Y).
chemin_orienté(X, Y) :- arete(X, Z), chemin_orienté(Z, Y).

% Il y a un chemin orienté de longueur 1 s'il y a une arête les reliant dans l'ordre.
% Il y a un chemin orienté de longueur n s'il y a un chemin de n arêtes.
chemin_orienté(X, Y, 1) :- arete(X, Y).
chemin_orienté(X, Y, N) :- arete(X, Z), chemin_orienté(Z, Y, M), N is 1+M.

% Il y a un chemin orienté de longueur 1 s'il y a une arête les reliant dans n'importe quel ordre.
chemin(X, Y) :- chemin_orienté(X, Y).
chemin(X, Y) :- chemin_orienté(Y, X).
chemin(X, Y) :- chemin_orienté(Z, X), chemin_orienté(Z, Y).

% Le prédicat est vrai si tous les sommets de la liste sont reliés les uns aux autres.
connecte([]).
connecte([X]) :- chemin(X, _).
connecte([X | [Y]]) :- chemin(X, Y).
connecte([X | [Y | Q]]) :- chemin(X, Y), connecte(Q).
