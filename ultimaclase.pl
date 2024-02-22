alumno(cristian,22,espanol).

cursa(cristian,matematica,7).
cursa(cristian,geografia,8).
cursa(cristian,espanol,9).

%%% Café Veloz
% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).
jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).
%a. passarella toma todo lo que no tome Maradona
tomo(pasarella,Sustancia):-
    % sustancia(Sustancia),
    not(tomo(maradona,Sustancia)).

%b. pedemonti toma todo lo que toma chamot y lo que toma Maradona
tomo(pedemonti,Sustancia):-
    tomo(chamot,Sustancia),
    tomo(maradona,Sustancia).

sustancia(Sustancia):-
    tomo(_, Sustancia).

%3) Si agregamos los siguientes hechos:
amigo(maradona, caniggia).
amigo(caniggia, balbo).
amigo(balbo, chamot).
amigo(balbo, pedemonti).

%%% Duolengua
alumno(cristian, 22, español).

cursa(cristian, ingles, 7).
cursa(cristian, portugues, 15).

% cursa(_, _, Nivel), Nivel >= 15.

%%% MyTube

% usuario(nickname, suscriptores).
% contenido(nickname, contenido).

usuario(markitocuchillos, 45000).
usuario(sebaElDolar, 5000).
usuario(tiqtoqera, 40000).
usuario(user99018, 1).


subio(markitocuchillos, video("Gatito toca el piano", 45, 50, 1000)).
subio(markitocuchillos, video("Gatito toca el piano 2", 65, 2, 2)).
subio(sebaElDolar, video("300 ¿es el dólar o es Esparta?", 60000, 2000, 1040500)).
subio(sebaElDolar, stream).
subio(tiqtoqera, short(15, 800000, [goldenHauer, cirugiaEstetica])).
subio(tiqtoqera, short(20, 0, [])).
subio(tiqtoqera, stream).


mytuber(Usuario):- subio(Usuario, _).

% milenial(Usuario):- subio(Usuario, video(_, _, 1000, _)).
% milenial(Usuario):- subio(Usuario, video(_, _, _, 1000)).

milenial(Usuario):- subio(Usuario, Contenido), contenidoMilenial(Contenido).

contenidoMilenial(video(_, _, 1000, _)).
contenidoMilenial(video(_, _, _, 1000)).

% tieneLikes(Usuario, Likes):- subio(Usuario, video(_, _, _, Likes)).

% nuncaSubio(Usuario):- not(subio(Usuario, video(_, _, _, _))).

nuncaSubio(Usuario):- usuario(Usuario, _), not(mytuber(Usuario)).

nivelEngagement(Usuario, Engagement):-
    mytuber(Usuario),
    findall(
        EngagementContenido,
        (subio(Usuario, Contenido), engagementContenido(Contenido, EngagementContenido)),
        EngagementContenidos
    ),
    sumlist(EngagementContenidos, Engagement).

engagementContenido(stream, 2000).

engagementContenido(short(_, Likes, _), Likes).

engagementContenido(video(_, _, Views, Likes), Engagement):-
    Engagement is Views + Likes.

engagement2(Usuario, 2000):-
    subio(Usuario, stream).

engagement2(Usuario, Likes):-
    subio(Usuario, short(_, Likes, _)).


% puntaje(mytuber, puntaje)
puntaje(MyTuber, Puntaje):-
    mytuber(MyTuber),
    findall(
        PuntajeObjetivo,
        puntajeObjetivo(MyTuber, PuntajeObjetivo),
        PuntajesObjetivo
    ),
    sumlist(PuntajesObjetivo, Puntaje).

puntajeContenido(short(_, _, Filtros), 2):-
    Filtros \= [].

puntajeContenido(Contenido, 1):-
    engagementContenido(Contenido, Engagement),
    Engagement > 10000.

puntajeContenido(Contenido, 2):-
    videoLargo(Contenido).

puntajeObjetivo(MyTuber, PuntajeObjetivo):-
    subio(MyTuber, Contenido),
    puntajeContenido(Contenido, PuntajeObjetivo).

puntajeObjetivo(MyTuber, 1):-
    subio(MyTuber, Contenido),
    subio(MyTuber, OtroContenido),
    Contenido \= OtroContenido.

puntajeObjetivo(MyTuber, 10):-
    nivelEngagement(MyTuber, Engagement),
    Engagement > 10000.

videoLargo(video(_, Duracion, _, _)):-
    Duracion > 6000.

elMejor(MyTuber):-
    puntaje(MyTuber, Puntaje),
    forall(
        (puntaje(OtroMyTuber, PuntajeOtro), MyTuber \= OtroMyTuber),
        Puntaje > PuntajeOtro
    ).

administra(martin, sebaElDolar).
administra(martin, markitocuchillos).
administra(inia, martin).
administra(inia, gaston).
administra(gaston, tiqtoqera).
administra(fernando, inia).

representa(Manager, MyTuber):-
    %mytuber(MyTuber),
    administra(Manager, MyTuber).

representa(Manager, MyTuber):-
    administra(Manager, Otro),
    representa(Otro, MyTuber).  
