sangre(harry, mestiza).
sangre(draco, pura).
sangre(hermione, impura).


caracteristica(harry, corajudo).
caracteristica(harry, amistoso).
caracteristica(harry, orgulloso).
caracteristica(harry, inteligente).
caracteristica(hermione, inteligente).
caracteristica(hermione, orgullosa).
caracteristica(hermione, responsable).
caracteristica(draco, inteligente).
caracteristica(draco, orgulloso).

odiaCasa(draco, hufflepuff).
odiaCasa(harry, slytherin).
odiaCasa(harry, slytherin).


caracteristicaPrincipalCasa(gryffindor, corajudo).

caracteristicaPrincipalCasa(slytherin, orgulloso).
caracteristicaPrincipalCasa(slytherin, inteligente).

caracteristicaPrincipalCasa(ravenclaw, inteligente).
caracteristicaPrincipalCasa(ravenclaw, responsable).

caracteristicaPrincipalCasa(hufflepuff, amistoso).
casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).
mago(Mago) :- sangre(Mago, _).

permiteEntrar(Casa, Mago) :-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin,
    sangre(Mago, _).

permiteEntrar(slytherin, Mago) :-
    sangre(Mago, TipoSangre),
    TipoSangre \= impura.

caracterApropiado(Mago, Casa) :-
    forall(caracteristicaPrincipalCasa(Casa, Caracteristica), caracteristica(Mago, Caracteristica)).
%esta bien esto, podemos agregar una regla especifica para un caso?
casaSeleccionada(Mago, Casa) :-
    permiteEntrar(Casa, Mago),
    caracterApropiado(Mago, Casa),
    not(odiaCasa(Mago, Casa)).

casaSeleccionada(hermione, gryffindor).



%esta bien usar recursion en este caso? Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser amistosos y cada uno podría estar en la misma casa que el siguiente. No hace falta que sea inversible, se consultará de forma individual.
cadenaDeAmistades([Mago1, Mago2 | Resto]) :-
    caracteristica(Mago1, amistoso),
    casaSeleccionada(Mago1, Casa),
    casaSeleccionada(Mago2, Casa),
    cadenaDeAmistades([Mago2 | Resto]).
cadenaDeAmistades([Mago]) :-
    caracteristica(Mago, amistoso).

%%%%%%%%%%%punto 2%%%%%%%%%%%%%%%
malaAccion(andarFueraDeCama, 50).
malaAccion(irAlBosque, 50).
malaAccion(irAlTercerPiso, 75).
malaAccion(irALaSeccionRestringidaDeLaBiblioteca, 10).

buenaAccion(ganarPartidaAjedrezMagico, 50).
buenaAccion(usarIntelectoParaSalvarAmigos, 50).
buenaAccion(ganarleAVoldemort, 60).

realizoAccion(harry, andarFueraDeCama).
realizoAccion(hermione, irAlTercerPiso).
realizoAccion(hermione, irALaSeccionRestringidaDeLaBiblioteca).
realizoAccion(harry, irAlBosque).
realizoAccion(harry, irAlTercerPiso).
realizoAccion(draco, irALasMazmorras).
realizoAccion(ron, ganarPartidaAjedrezMagico).
realizoAccion(hermione, usarIntelectoParaSalvarAmigos).
realizoAccion(harry, ganarleAVoldemort).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

buenAlumno(Mago) :-
    realizoAccion(Mago, _),
    not((realizoAccion(Mago, Accion), malaAccion(Accion, _))).

accionRecurrente(Accion) :-
    realizoAccion(Mago1, Accion),
    realizoAccion(Mago2, Accion),
    Mago1 \= Mago2.

puntajeTotaldeCasa(Casa, PuntajeTotal) :-
    findall(Puntaje, (esDe(Mago, Casa), puntajeMago(Mago, Puntaje)), Puntajes),
    sum_list(Puntajes, PuntajeTotal).

puntajeMago(Mago, Puntaje) :-
    findall(Puntos, (realizoAccion(Mago, Accion), puntosPorAccion(Accion, Puntos)), PuntosAccion),
    sum_list(PuntosAccion, Puntaje).

puntosPorAccion(Accion, Puntos) :-
    buenaAccion(Accion, Puntos), !.
puntosPorAccion(Accion, -Puntos) :-
    malaAccion(Accion, Puntos).


casaGanadora(Casa) :-
    puntajeTotaldeCasa(Casa, Puntaje),
    forall((puntajeTotaldeCasa(OtraCasa, OtroPuntaje), OtraCasa \= Casa), Puntaje > OtroPuntaje).

respondioPregunta(hermione, dondeSeEncuentraUnBezoar, 20, snape).
respondioPregunta(hermione, comoHacerLevitarUnaPluma, 25, flitwick).

puntosPorAccion(Accion, Puntos) :-
    buenaAccion(Accion, Puntos), !.
puntosPorAccion(Accion, -Puntos) :-
    malaAccion(Accion, Puntos).
puntosPorAccion(Accion, Dificultad) :-
    respondioPregunta(_, Accion, Dificultad, Profesor),
    (Profesor = snape -> Puntos is Dificultad / 2 ; Puntos = Dificultad).