%Element en tête de la liste
head(X, [X | _]).

%Ajouter un élément en tête de la liste
addhead(X, L, [X | L]).

%Dernier élément de la liste
last(X, [X]).
last(X, [_ | L]) :- last(X, L).

%Ajouter un élément à la fin de la liste
addlast(X, [], [ X ]).
addlast(X, [Y | Q1], Q3) :- addlast(X,Q1,Q2), addhead(Y, Q2, Q3).

%Inverser l'ordre des éléments d'une liste
reverse([X], [X]).
reverse([X | L1], L2) :- reverse(L1, L3), addlast(X, L3, L2).
