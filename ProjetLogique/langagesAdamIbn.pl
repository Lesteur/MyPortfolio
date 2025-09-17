%Longueur d'un mot.
longueur([], 0).
longueur([_ | Q], N) :- longueur(Q, N2), N is N2 + 1.

%Nombre d'un même élément dans une liste.
nombre_de([], _, 0).
nombre_de([X | Q], A, N) :- nombre_de(Q, A, N2), A == X, N is N2 + 1.
nombre_de([X | Q], A, N) :- nombre_de(Q, A, N2), A \== X, N is N2.

%Le mot vide est dans le langage
langage([]).
%Si S est un mot valide, alors abS est un mot valide .
langage([a, b | S]) :- langage(S).

%Si S est valide, aS est valide.
langage1([b]).
langage1([a | S]) :- langage1(S).

%Si S est valide, aS est valide.
langagea([]).
langagea([a | S]) :- langagea(S).

%Si S est valide, bS est valide.
langageb([]).
langageb([b | S]) :- langageb(S).

%Si S est valide, cS est valide.
langagec([]).
langagec([c | S]) :- langagec(S).

%Si S est valide, aS est valide.
langage2([a]).
langage2([a | S]) :- langageb(S).

%Si aS est valide, aaS est valide, si bS est valide, bbS est valide.
langage3([]).
langage3([a | S]) :- langage3(S).
langage3([b | S]) :- langageb(S).

%Si S est valide, aaS est valide.
langage4([]).
langage4([a, a | S]) :- langage4(S).

%Si S est valide, aSb est valide.
langage5([]).
langage5(L) :- langage3(L), nombre_de(L, a, N1), nombre_de(L, b, N2), N1 == N2.

%Si S est valide, aSa est valide, bSb est valide.
langage6([]).
langage6([_]).
langage6([X, X]).
langage6([X | Q]) :- langage6(Q2), pop(Q, Q2, Y), X == Y.

%Si S est valide, Sc est valide, aS est valide.
langage7ann([]).
langage7ann([b | S]) :- langage7ann(S).
langage7ann([c | S]) :- langagec(S).
langage7([]).
langage7([a | S]) :- langage7(S).
langage7([b | S]) :- langage7ann(S).
langage7([c | S]) :- langagec(S).

%Si S est valide, aSc est valide.
langage8([]).
langage8(L) :- langage7(L), nombre_de(L, a, N1), nombre_de(L, c, N3), N1 == N3.

%Si S est valide, aS est valide, Sa est valide.
langage9ann([]).
langage9ann([a | L]) :- langage9(L).
langage9ann([b | L]) :- langage9(L).
langage9(L) :- langage9ann(L), nombre_de(L, b, N), N < 2.

%Si S est valide, aSb est valide, bSa est valide.
langage10([]).
langage10(L) :- nombre_de(L, a, N1), nombre_de(L, b, N2), N1 == N2.

%Si S est valide, abSc est valide.
langage11([]).
langage11(L) :- langage7(L), nombre_de(L, a, N1), nombre_de(L, b, N2), nombre_de(L, c, N3), N1 == N3, N2 == N3, N1 == N2.
