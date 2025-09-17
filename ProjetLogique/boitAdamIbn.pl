% on ecrit boit(a, b) si a boit b

boit(john, the).
boit(alice, cafe).
boit(john, vin).
boit(bernard, the).
boit(coralie, vin).
boit(vincent, vodka).
boit(alexey, kefir).
boit(alexey, the).
boit(dorotea, vin).
boit(manon, biere).
boit(melodie, biere).
boit(otto, biere).
boit(abdoul, eau).
boit(elodie, chocolat).
boit(caroline, the).
boit(simon, eau).
boit(simon, cafe).
boit(simon, cafe).
boit(coralie, chocolat).
boit(otto, eau).
boit(abdoul, the).
boit(vincent, the).

boisson(X)  :-  boit(_, X).

personne(X) :- boit(X, _).
