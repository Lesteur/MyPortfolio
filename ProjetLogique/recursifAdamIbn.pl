% fact(n,r) où r est le produit de tous les nombres allant de 1 à n. 
fact(0, 1).
fact(N, R) :- N > 0, M is N - 1, fact(M, T), R is T*N.

% somme(n,r) où r est la somme de tous les nombres allant de 1 à n.
somme(1, 1).
somme(N, R) :- N > 1, M is N-1, somme(M, T), R is T+N.

% fibo(1, 1) et fibo(2, 1)
% fibo(n, r) où r est la somme de x et y où fibo(n-1,x) et fibo(n-2,y).
fibo(1, 1).
fibo(2, 1).
fibo(N, R) :- N > 2, T is N-1, S is N-2, fibo(T, X), fibo(S, Y), R is X+Y.

%ack(0, n) = n+1
%ack(m, o) = ack(m-1, 1) où m > 0
%ack(m, n) = ack(m-1, ack(m, n-1)) où m > 0 et n > 0
ack(M, N, T) :- M == 0, T is N+1.
ack(M, N, T) :- M > 0, N == 0, Z is M-1, ack(Z, 1, A), T is A.
ack(M, N, T) :- M > 0, N > 0, X is M-1, B is N-1, ack(M, B, Y), ack(X, Y, A), T is A.
