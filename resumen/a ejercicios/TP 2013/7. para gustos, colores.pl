/* para gustos, colores */

color(mabel, rosa).
color(ana, rosa).
color(mara, celeste).
color(mara, lila).
color(juan, X):- pastel(X).
color(pablo, azul).
color(X, azul):- mujer(X).
color(mabel, rojo).
color(X, rojo):- mayor(X), varon(X).
color(adrian, amarillo).
color(X, amarillo):- portenio(X).
color(ana, naranja).
color(juan, naranja).

portenio(mabel).
portenio(mara).
portenio(pablo).
mayor(ana).
mayor(pablo).
pastel(rosa).
pastel(celeste).
pastel(lila).

mujer(mabel).
mujer(ana).
mujer(mara).
varon(juan).
varon(pablo).
varon(adrian).

reunion(viernes, [mabel, ana, adrian, pablo]).
reunion(sabado, [mara, mabel, adrian, juan]).
reunion(domingo, [juan|T]):- findall(M, mayor(M), T).

iluminacion(Reunion, Color):- 
	reunion(Reunion, ListaI), member(Varon, ListaI), varon(Varon), color(Varon, Color), 
	member(Mujer, ListaI), mujer(Mujer), color(Mujer, Color).
	
/*
7 ?- color(mabel, X).
X = rosa ; X = azul ; X = rojo ; X = amarillo.

8 ?- color(ana, X).
X = rosa ; X = azul ; X = naranja.

9 ?- color(mara, X).
X = celeste ; X = lila ; X = azul ; X = amarillo.

10 ?- color(juan, X).
X = rosa ; X = celeste ; X = lila ; X = naranja.

11 ?- color(pablo, X).
X = azul ; X = rojo ; X = amarillo.

12 ?- color(adrian, X).
X = amarillo ;
*/

/*
14 ?- bagof(C, iluminacion(D,C), L).
D = domingo,
L = [rosa,naranja,azul] ;
D = sabado,
L = [amarillo,amarillo,rosa,celeste,lila] ;
D = viernes,
L = [amarillo,azul,azul,rojo,amarillo].
	
*/