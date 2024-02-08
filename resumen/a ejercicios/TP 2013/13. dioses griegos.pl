/* dioses griegos */

% diosBueno(Nombre, MortalFavorito, NivelDivinidad).
% diosMalo(Nombre, DiosesOdiados, NivelDivinidad).
% hijoDivino(DiosPadre, DiosHijo).

%hizo(Mortal, Accion).
% don(Dios, regalo(Accion,Regalo)).
% don(Dios, castigo(Accion,Castigo)).

diosMalo(urano,[apolo],60).
diosMalo(kronos,[zeus,urano,afrodita],90).
diosMalo(hades,[kronos,apolo],400).

diosBueno(zeus,hercules,500).
diosBueno(afrodita,eneas,50).
diosBueno(apolo,creso,80).

hijoDivino(afrodita,apolo).
hijoDivino(zeus,afrodita).
hijoDivino(kronos,zeus).
hijoDivino(kronos,urano).

mortal(hercules).
mortal(eneas).
mortal(teseo).
mortal(creso).
mortal(aquiles).

adora(hercules,zeus).
adora(eneas,zeus).
adora(eneas,hades).
adora(teseo,apolo).
adora(teseo,afrodita).
adora(aquiles,urano).
adora(aquiles,kronos).

don(zeus,regalo(hacerOfrenda,placer)).
don(zeus,regalo(pensar,vino)).
don(zeus,castigo(maldecir,rayo)).
don(afrodita,regalo(enamorarse,vino)).
don(afrodita,regalo(pensar,oro)).
don(urano,castigo(ignorar,sequa)).
don(apolo,regalo(pensar,vino)).
don(apolo,regalo(construir,salud)).

accion(eneas,pensar).
accion(hercules,maldecir).
accion(teseo,maldecir).
accion(aquiles,ignorar).
accion(eneas,ignorar).
accion(hercules,construir).

% status_religioso_de_un_mortal
monoteista(Mortal):- mortal(Mortal), adora(Mortal, Dios), not((adora(Mortal, Dios2), Dios2 \= Dios)).
ateo(Mortal):- mortal(Mortal), not(adora(Mortal,_)).
indeciso(Mortal):- mortal(Mortal), adora(Mortal,Dios_bueno), adora(Mortal, Dios_malo), diosBueno(Dios_bueno, _, _), diosMalo(Dios_malo, _, _).

dios_loco(Dios):- diosBueno(Dios, _, _), don(Dios, castigo(_,_)).
dios_loco(Dios):- diosMalo(Dios, _, _), don(Dios, regalo(_,_)).

regalo_divino(Dios, Mortal, Regalo):- adora(Mortal, Dios), accion(Mortal, Accion), don(Dios, regalo(Accion, Regalo)).
regalo_divino(Dios, Favorito, Regalo):- diosBueno(Dios, Favorito, _), don(Dios, regalo(_, Regalo)).

castigo_divino(Dios, Mortal, Castigo):- accion(Mortal, Accion), don(Dios, castigo(Accion, Castigo)), not(adora(Mortal, Dios)).
castigo_divino(Dios, Mortal, culpa):- diosMalo(Dios, Odia, _), member(D, Odia), adora(Mortal, D).

mimado(Dios, Mortal):- diosBueno(Dios, Mortal, _).
mimado(Dios, Mortal):- ancestro(Ancestro, Dios), diosBueno(Ancestro, Mortal, _).

ancestro(Ancestro, Dios):- hijoDivino(Ancestro, Dios).
ancestro(Ancestro, Dios):- hijoDivino(Ancestro, Otro), ancestro(Otro, Dios).

tiende_a_lo_maligno(Mortal):- mortal(Mortal), findall(Castigo, castigo_divino(_, Mortal, Castigo), Castigos), length(Castigos, N), N >= 4.
tiende_a_lo_maligno(Mortal):- adora(Mortal, Dios), diosMalo(Dios, _, Nivel), Nivel > 100.
tiende_a_lo_maligno(Mortal):- mortal(Mortal), forall(adora(Mortal, Dios), diosMalo(Dios, _, _)), not(ateo(Mortal)), not(monoteista(Mortal)).

puede_bendecir(Mortal, OtroMortal):- mortal(Mortal), mortal(OtroMortal), Mortal \= OtroMortal,
	findall(nivel(Dios, Nivel), (adora(Mortal, Dios), diosBueno(Dios, _, Nivel)), Dioses), divinidad(Dioses, N), 
	findall(nivel(Dios2, Nivel2), (adora(OtroMortal, Dios2), diosMalo(Dios2, _, Nivel2)), Dioses2), divinidad(Dioses2, N2), N > N2.
	
divinidad([nivel(_, Nivel)|Dioses], N):- divinidad(Dioses, N2), N is N2 + Nivel.
divinidad([], 0).

es_un_santo(Mortal):- mortal(Mortal), forall((mortal(M), M \= Mortal), puede_bendecir(Mortal,M)).

accion_conveniente(Accion):- accion(Accion), forall(diosBueno(Dios, _, _), don(Dios, regalo(Accion, _))),
	 forall(diosMalo(Dios, _, _), not(don(Dios, castigo(Accion, _)))).
	 
accion(Accion):- setof(A, D ^ R ^ C ^ (don(D, regalo(A, R)); don(D, castigo(A, C))), Acciones), member(Accion, Acciones).

accion_mistica(Accion):- accion(Accion), findall(D, don(D, regalo(Accion, _)), Ds), length(Ds, 3).
accion_mistica(Accion):- accion(Accion), don(Dios, regalo(Accion, _)), divinidad2(Dios, 80).

divinidad2(Dios, Divinidad):- diosBueno(Dios, _, Divinidad).
divinidad2(Dios, Divinidad):- diosMalo(Dios, _, Divinidad).

dios_quisquilloso(Dios):- diosMalo(Dios, Lista, _), regalan_vino(Lista).

regalan_vino([H,_|T]):- don(H, regalo(_, vino)), regalan_vino(T).
regalan_vino([H]):- don(H, regalo(_, vino)).
regalan_vino([]).

/* sin repetidos
nub(L,R) :- nub(L,[],R).
nub([],_,[]).
nub([H|T],A,R)     :-     member(H,A),  nub(T,A,R).
nub([H|T],A,[H|R]) :- not(member(H,A)), nub(T,[H|A],R).
*/


