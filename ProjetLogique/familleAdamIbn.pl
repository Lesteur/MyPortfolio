%liste des hommes
homme(jean).
homme(oscar).
homme(emmanuel).
homme(aurelien).
homme(jaques).
homme(franc).
homme(dominic).
homme(olivier).
homme(lucas).
homme(florent).
homme(simon).
homme(vincent).
homme(alain).
homme(frederic).
homme(luc).
homme(xavier).
homme(louis).
homme(alexandre).
homme(jules).
homme(didier).
homme(eric).
homme(antoine).
homme(paul).
homme(hugo).
homme(samuel).
homme(pierre).
homme(yves).
homme(claude).
homme(remy).
homme(maxime).

%liste des femmes
femme(jeanne).
femme(caroline).
femme(elodie).
femme(aurelie).
femme(beatrice).
femme(severine).
femme(helene).
femme(marion).
femme(antonine).
femme(melodie).
femme(edith).
femme(mireille).
femme(josephine).
femme(anne).
femme(louise).
femme(marie).
femme(lisa).
femme(julie).
femme(francoise).
femme(claire).
femme(brigitte).
femme(monica).
femme(melanie).
femme(megan).
femme(charlotte).
femme(aure).
femme(emmanuelle).
femme(olivia).
femme(catherine).
femme(pauline).

%liste des parents
parent(maxime, catherine).
parent(maxime, olivia).
parent(emmanuelle, catherine).
parent(emmanuelle, olivia).
parent(remy, claude).
parent(catherine, claude).
parent(yves, aure).
parent(olivia, aure).
parent(yves, charlotte).
parent(olivia, charlotte).
parent(pierre, samuel).
parent(pierre, hugo).
parent(pierre, pauline).
parent(pierre, paul).
parent(pierre, megan).
parent(aure, samuel).
parent(aure, hugo).
parent(aure, pauline).
parent(aure, paul).
parent(aure, megan).
parent(charlotte, melanie).
parent(charlotte, antoine).
parent(eric, melanie).
parent(didier, antoine).
parent(aurelien, emmanuel).
parent(melodie, emmanuel).
parent(jaques, caroline).
parent(aurelie, caroline).
parent(franc, florent).
parent(beatrice, florent).
parent(dominic, mireille).
parent(severine, mireille).
parent(dominic, simon).
parent(severine, simon).
parent(olivier, edith).
parent(helene, edith).
parent(olivier, xavier).
parent(helene, xavier).
parent(lucas, anne).
parent(lucas, josephine).
parent(antonine, anne).
parent(marion, josephine).
parent(xavier, luc).
parent(xavier, frederic).
parent(edith, alain).
parent(edith, lisa).
parent(simon, alain).
parent(simon, lisa).
parent(mireille, luc).
parent(mireille, frederic).
parent(florent, jeanne).
parent(caroline, oscar).
parent(emmanuel, oscar).
parent(oscar, jean).
parent(jeanne, jean).
parent(oscar, elodie).
parent(jeanne, elodie).
parent(oscar, monica).
parent(jeanne, monica).
parent(oscar, brigitte).
parent(jeanne, brigitte).
parent(vincent, louis).
parent(lisa, louis).
parent(alain, alexandre).
parent(marie, alexandre).
parent(frederic, claire).
parent(louise, claire).
parent(frederic, jules).
parent(louise, jules).
parent(luc, francoise).
parent(anne, francoise).
parent(luc, julie).
parent(mireille, jeanne).
parent(anne, julie).

% X est un père s'il est parent de Y et que c'est un homme.
pere (X, Y) :- parent (X, Y) , homme (X).
% X est une mère si elle est parent de Y et que c'est une femme.
pere(X, Y) :- parent(X, Y), femme(X).
% X est un fils si Y est son parent et que c'est un homme.
fils(X, Y) :- parent(Y, X), homme(X).
% X est une fille si Y est son parent et que c'est une femme.
fille(X, Y) :- parent(Y, X), femme(X).
% X est un grandpere s'il existe Z tel que X est parent de Z qui lui même est parent de Y et que c'est un homme.
grandpere(X, Y) :- parent(X, Z), parent(Z, Y), homme(X).
% X est une grandmere s'il existe Z tel que X elle est parent de Z qui lui même est parent de Y et que c'est une femme.
grandmere(X, Y) :- parent(X, Z), parent(Z, Y), femme(X).
% X est un frère s'il existe Z tel que Z est le parent commun de X et Y et que X est un homme.
frere(X, Y) :- parent(Z, X), parent(Z, Y), X \== Y, homme(X).
% X est une soeur s'il existe Z tel que Z est le parent commun de X et Y et que X est une femme.
soeur(X, Y) :- parent(Z, X), parent(Z, Y), X \== Y, femme(X).
% X est un cousin s'il existe Z et T tel que Z est le parent de X et qu'il a un frère ou une soeur T qui est le parent de Y et que X est un homme.
cousin(X, Y) :- parent(Z, X), frere(Z, T), parent(T, Y), X \== Y, homme(X).
cousin(X, Y) :- parent(Z, X), soeur(Z, T), parent(T, Y), X \== Y, homme(X).
% X est une cousine s'il existe Z et T tel que Z est le parent de X et qu'il a un frère ou une soeur T qui est le parent de Y et que X est une femme.
cousine(X, Y) :- parent(Z, X), frere(Z, T), parent(T, Y), X \== Y, femme(X).
cousine(X, Y) :- parent(Z, X), soeur(Z, T), parent(T, Y), X \== Y, femme(X).
