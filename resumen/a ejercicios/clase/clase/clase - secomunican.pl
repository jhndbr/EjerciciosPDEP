habla(matias, frances).
habla(julia, frances).
habla(julia, ingles).
habla(pedro, aleman).
seComunican(Persona, OtraPersona) :- habla(Persona, Idioma), habla(OtraPersona, Idioma), Persona \= OtraPersona.

numero(1).
numero(2).
numero(3).

suma(A,B,C):- numero(A), between(1,10,B), C is A + B.

bueno(ana).
bueno(martin).
bueno(alejandro).
bueno(federico).

malo(P) :- persona(P), not(bueno(P)).

persona(Persona) :- bueno(Persona).
persona(matias).
persona(analia).


nacio(juan, fecha(02, 11, 1992)).
nacio(ana,  fecha(10, 10, 2001)).
nacio(julia,  fecha(10, 10, 2001)).
nacio(pedro,  fecha(10, 10, 2001)).


nacieronelmismodia(Persona, OtraPersona) :- nacio(Persona, Fecha), nacio(OtraPersona, Fecha), Persona \= OtraPersona.
cumplenanios(A,B) :- nacio(A,fecha(D,M,_)), nacio(B,fecha(D,M,_)), A \= B.


