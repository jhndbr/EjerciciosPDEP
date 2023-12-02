/* pdep smartphones */

%compatible(smartphone(Marca, 		Modelo), 			Sistema)
compatible(smartphone(nokia, 		lumia710), 			windowsPhone).
compatible(smartphone(nokia, 		n8), 				nokiaBelle).
compatible(smartphone(motorola, 	xT615), 			android(2.37,	[market, flash,multitask])).
compatible(smartphone(motorola, 	backflip), 			android(1.6, 	[market])).
compatible(smartphone(motorola, 	razr), 				android(4.12, 	[market, flash,multitask])).
compatible(smartphone(samsung, 		galaxyS4), 			android(4.22, 	[market, flash,multitask])).
compatible(smartphone(samsung, 		galaxySAdvance), 	android(4.22, 	[market, flash,multitask])).
compatible(smartphone(sonyEricsson, vivaz), 			symbian(s60)).
compatible(smartphone(sonyEricsson, x8), 				android(2.1, 	[market, multitask])).
compatible(smartphone(mac, 			iphone4), 			iOS(			[market, multitask, itunes])).

%Y se conocen los precios de cada uno de los modelos así:
%precio(modelo, precio).
/*
precio(galaxyS4, 3100).
precio(galaxySAdvance,2500).
precio(lumia710,1500).
precio(n8,1600).
precio(xT615,2000).
precio(backflip,900).
precio(vivaz,1100).
precio(x8,1200).
precio(iphone4,3000).
precio(razr, 2500).
*/

precio(backflip,900).
precio(galaxyS4, 3100).
precio(galaxySAdvance,2500).
precio(iphone4,3000).
precio(lumia710,1500).
precio(n8,1600).
precio(razr, 2500).
precio(vivaz,1100).
precio(x8,1200).
precio(xT615,2000).



% 1. entrada en calor

innovadora(Empresa):- compatible(smartphone(Empresa, Modelo), Sistema), 
	compatible(smartphone(Empresa, Modelo2), Sistema2), Modelo \= Modelo2 , Sistema \= Sistema2.
	
insistente(Empresa):- compatible(smartphone(Empresa, Modelo), Sistema), 
	compatible(smartphone(Empresa, Modelo2), Sistema), Modelo \= Modelo2.
	
marketinera(Empresa):- innovadora(Empresa), insistente(Empresa).

% 2. las aplicaciones y sus requerimientos

cumple_requisito(mapa_loco, nokiaBelle).
cumple_requisito(mapa_loco, symbian(s60)).
cumple_requisito(mapa_loco, Sistema):- compatible(_, Sistema), Sistema = iOS(_).

cumple_requisito(acelerador_de_descargas, windowsPhone).
cumple_requisito(acelerador_de_descargas, Sistema):- compatible(_, Sistema), tiene_app(market, Sistema).

cumple_requisito(haskell_mobile, Sistema):- compatible(_, Sistema), tiene_app(multitask,  Sistema).

tiene_app(App, android(_, L)):- member(App, L).
tiene_app(App, iOS(L)):- member(App, L).

% 3. corre_aplicacion(Smartphone, App)

corre_aplicacion(Smartphone, App):- compatible(Smartphone, Sistema), cumple_requisito(App, Sistema).

% 4. funciona_en(App, Smartphones)

funciona_en(App, Smartphones):- app(App), setof(S, App ^ corre_aplicacion(S, App), Smartphones).

app(mapa_loco).
app(acelerador_de_descargas).
app(haskell_mobile).

% 5. es_copada(Marca)

es_copada(Marca):- /* marketinera(Marca), */  marca(Marca), forall(compatible(smartphone(Marca, _), Sistema), 
	(cumple_requisito(App, Sistema), cumple_requisito(App2, Sistema), App \= App2)).
	
marcas(Marcas):- setof(Marca, Modelo ^ Sistema ^ compatible(smartphone(Marca, Modelo), Sistema), Marcas).
marca(M):- marcas(Marcas), member(M, Marcas).

%6. el_desterrado(Sistema)

el_desterrado(Sistema):- sistema(Sistema), not(cumple_requisito(acelerador_de_descargas, Sistema)), not(cumple_requisito(haskell_mobile, Sistema)), 
	not(cumple_requisito(mapa_loco, Sistema)).

sistemas(Sistemas):- setof(S, A ^ B ^ compatible(smartphone(A, B), S), Sistemas).
sistema(Sistema):- sistemas(Sistemas), member(Sistema, Sistemas).

% 7. mayor_cantidad_de_modelos(Marca):- 

mayor_cantidad_de_modelos(Marca):- marca(Marca), cantidad_de_modelos(Marca, Cant), 
	forall((marca(Marca2), Marca2 \= Marca, cantidad_de_modelos(Marca2, N)), Cant > N).

cantidad_de_modelos(Marca, N):- findall(Modelo, compatible(smartphone(Marca, Modelo), _), Modelos), length(Modelos, N).

mayor_cantidad_de_modelos_2(Marca):- marcas(Marcas), maximo(Marca, Marcas).

maximo(X, [H,J|T]):-     mayor_o_igual(H,J),  maximo(X, [H|T]).
maximo(X, [H,J|T]):- not(mayor_o_igual(H,J)), maximo(X, [J|T]).
maximo(X, [X]).

mayor_o_igual(H,J):- cantidad_de_modelos(H, N), cantidad_de_modelos(J, N2), N >= N2.

% 8. nombres_SO(Sistemas)

nombres_SO(Sistemas):- sistemas(L), obtener_nombres(L, L2), nub(L2, Sistemas).

obtener_nombres([H|T], [H2|T2]):- functor(H, H2, _), obtener_nombres(T, T2).
obtener_nombres([],[]).

/* no funca eliminar_repetidos([1,1,2,2,3,3,3,3],L). tira muchas respuestas 
eliminar_repetidos([H|T], T2):- member(H, T), eliminar_repetidos(T, T2).
eliminar_repetidos([H|T], [H|T2]):-not(member(H, T)), eliminar_repetidos(T, T2).
eliminar_repetidos([],[]).
*/

nub(L,R) :- nub(L,[],R).
nub([],_,[]).
nub([H|T],A,R)     :-     member(H,A),  nub(T,A,R).
nub([H|T],A,[H|R]) :- not(member(H,A)), nub(T,[H|A],R).

% 9. corre_en(sistema, conjunto de marcas)

corre_en(Nombre, Marcas):- nombres_SO(Nombres), member(Nombre, Nombres), setof(Marca, Nombre ^ soporta(Marca, Nombre), Marcas).

soporta(Marca, Nombre):- compatible(smartphone(Marca, _), Sistema), functor(Sistema, Nombre, _).

% 10. compatible_con_todos_menos_uno(Marca)

compatible_con_todos_menos_uno(Marca):- marca(Marca), soporta(Marca, Nombre), Nombre \= android, 
	forall((soporta(Marca, N), N \= Nombre), soporta(Marca, android)).

% pueden estar conectados
% 11. pueden_conectarse

pueden_conectarse(Persona):- tiene(Persona, _).
pueden_conectarse(Persona):- conocidos2(Persona, Otra), tiene(Otra, _).

%tiene(Persona, Smartphone).
tiene(mariano, smartphone(mac, iphone4)).
tiene(rodrigo, smartphone(samsung, galaxyS4)).
conocidos(hernan,mariano).
conocidos(juan, hernan).
conocidos(martina,pepe).

conocidos1(A, B):- conocidos(A, B).
conocidos1(A, C):- conocidos(A, B), conocidos1(B, C).

conocidos2(A, B):- conocidos1(A, B).
conocidos2(A, B):- conocidos1(B, A).

% 12. Todas las combinaciones de smartphones posibles

smartphones_posibles(Monto, SmartphonesPosibles):- smartphones(Smartphones), alcanza(Monto, Smartphones, SmartphonesPosibles).

smartphones(Ss):- setof(Modelo, Precio ^ precio(Modelo, Precio), Ss).

alcanza(Monto, [H|T], [H|T2]):- precio(H, P), P =< Monto, Monto2 is Monto - P, alcanza(Monto2, T, T2).
alcanza(Monto, [_|T], T2):- alcanza(Monto, T, T2).
alcanza(_, [], []).



