/* gossip */

gustaDe(luis,nora).
gustaDe(roque,nora).
gustaDe(roque,ana).
gustaDe(marcos,zulema).
gustaDe(juan,nuria).

gustaDe(X,zulema):- gustaDe(X,ana).
gustaDe(juan,X):- gustaDe(roque,X).
gustaDe(X,Y):- gustaDe(X,ana).

compiten(X,Y):- gustaDe(X,Z), gustaDe(Y,Z).

debeDinero(juan,marcos).
debeDinero(juan,roque).

/*
?gustaDe(juan,A).
7. A = nuria.
10. A = X.
11. X = juan, Y = A.

?gustaDe(A,zulema).
6. A = marcos.
9. A = X.
10. A = juan, X = zulema.
11. A = X, Y = zulema.

?gustaDe(marcos,ana).
11. X = marcos, Y = ana.

?gustaDe(juan,zulema).
9. X = juan.
10. X = zulema.
11. X = juan, Y = zulema.

?gustaDe(A,B).
todas.

b) compiten relaciona dos personas a las cuales les gusta la misma persona
*/