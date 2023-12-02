% Base de conocimientos inicial

% vocaloid(nombre, canciones)
vocaloid(megurineLuka, cancion(nightFever, 4)).
vocaloid(megurineLuka, cancion(foreverYoung, 5)).
vocaloid(hatsuneMiku, cancion(tellYourWorld, 4)).
vocaloid(gumi, cancion(foreverYoung, 4)).
vocaloid(gumi, cancion(tellYourWorld, 5)).
vocaloid(seeU, cancion(novemberRain, 6)).
vocaloid(seeU, cancion(nightFever, 5)).
vocaloid(kaito, cancion()).

unvocaloid(megurineLuka,_).
unvocaloid(hatsuneMiku,_).
unvocaloid(gumi,_).
unvocaloid(seeU,_).
% cancion(nombre, duracion)
cancion(nightFever, _).
cancion(foreverYoung, _).
cancion(tellYourWorld, _).
cancion(novemberRain, _).


sabeAlMenos(Vocaloid,Cantidad):-
    unvocaloid(Vocaloid,_),
    findall(Cancion, vocaloid(Vocaloid, Cancion), Canciones),
    length(Canciones, NumeroCanciones),
    NumeroCanciones >= Cantidad.  

duracionTotalMenor(Vocaloid, Duracion):-
    duracionTotal(Vocaloid, DuracionTotal),
    DuracionTotal < Duracion. 

duracionTotal(Vocaloid, DuracionTotal):-
    unvocaloid(Vocaloid,_),
    findall(DuracionCancion, (vocaloid(Vocaloid,cancion(_, DuracionCancion))), Duraciones),
    sum_list(Duraciones, DuracionTotal).


esNovedoso(Vocaloid):-
sabeAlMenos(Vocaloid, 2),
duracionTotalMenor(Vocaloid, 15).

esAcelerado(Vocaloid):-
    unvocaloid(Vocaloid,_),
    findall(Duracion, vocaloid(Vocaloid, cancion(_, Duracion)), Duraciones),
    not((member(Duracion, Duraciones), Duracion > 4)).

% Hechos que representan los conciertos
concierto(gigante, 'Miku Expo', estados_unidos, 2000, 2, 6).
concierto(gigante, 'Magical Mirai', japon, 3000, 3, 10).
concierto(mediano, 'Vocalekt Visions', estados_unidos, 1000, _, 9).
concierto(pequeno, 'Miku Fest', argentina, 100, _, 4).
%Concierto(tipo,nombre,pais, puntosdefama,cancionesminimas,duraiconrequerida)
puedeParticiparEnConcierto(hatsuneMiku, Concierto):- 
    concierto(_, Concierto, _, _, _, _).
puedeParticiparEnConcierto(Vocaloid, Concierto):-
    concierto(Tipo, Concierto, _, _, MinCanciones, DuracionRequerida),
    cumpleRequisitosConcierto(Vocaloid, Tipo, MinCanciones, DuracionRequerida).

cumpleRequisitosConcierto(Vocaloid, gigante, MinCanciones, DuracionMinima):-
    sabeAlMenos(Vocaloid, MinCanciones),
    not(duracionTotalMenor(Vocaloid, DuracionMinima)).

cumpleRequisitosConcierto(Vocaloid, mediano, _, DuracionMaxima):-
    duracionTotalMenor(Vocaloid, DuracionMaxima).

cumpleRequisitosConcierto(Vocaloid, pequeno, _, DuracionMinima):-
    vocaloid(Vocaloid, cancion(_, Duracion)),
    Duracion > DuracionMinima.

nivelDeFama(Vocaloid, NivelFama):-
   famaTotal(Vocaloid,TotalFama),
   cancionesTotal(Vocaloid,NumeroCanciones),
    NivelFama is TotalFama * NumeroCanciones.

famaTotal(Vocaloid,TotalFama):-
    unvocaloid(Vocaloid,Fama),
    findall(Fama, (concierto(_, Concierto, _, Fama, _, _), puedeParticiparEnConcierto(Vocaloid, Concierto)), Famas),
    sumlist(Famas, TotalFama).

cancionesTotal(Vocaloid,NumeroCanciones):-
    unvocaloid(Vocaloid,_),
    findall(Cancion, vocaloid(Vocaloid, Cancion), Canciones),
    length(Canciones, NumeroCanciones).

vocaloidMasFamoso(Vocaloid):-
    findall(NivelFama-Vocaloid, nivelDeFama(Vocaloid, NivelFama), NivelesFama),
    max_member(_-Vocaloid, NivelesFama).

conocido(megurineLuka,hatsuneMiku).
conocido(megurineLuka,gumi). 
conocido(gumi,seeU).
conocido(seeU,kaito).


unicoParticipanteEntreConocidos(Cantante,Concierto):- 
    puedeParticipar(Cantante, Concierto),
	not((conocido(Cantante, OtroCantante), 
    puedeParticipar(OtroCantante, Concierto))).

%Conocido directo
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, OtroCantante).

%Conocido indirecto
conocido(Cantante, OtroCantante) :- 
conoce(Cantante, UnCantante), 
conocido(UnCantante, OtroCantante).
