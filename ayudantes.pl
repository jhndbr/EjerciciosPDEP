% Las tareas son functores de la forma
% corregirTp(fechaEnQueElGrupoEntrego, grupo, paradigma)
% robarseBorrador(diaDeLaClase, horario)
% prepararParcial(paradigma).

tarea(vero, corregirTp(190, losMagiosDeTempeley, funcional)).
tarea(hernan, corregirTp(181, analiaAnalia, objetos)).
tarea(hernan, prepararParcial(objetos)).
tarea(alf, prepararParcial(funcional)).
tarea(nitu, corregirTp(190, analiaAnalia, funcional)).
tarea(ignacio, corregirTp(186, laTerceraEsLaVencida, logico)).
tarea(clara, robarseBorrador(197, turnoNoche)).
tarea(hugo, corregirTp(10, laTerceraEsLaVencida, objetos)).
tarea(hugo, robarseBorrador(11, turnoNoche)).
tarea(hernan, robarseBorrador(197, turnoManana)).

ayudante(vero).
ayudante(hernan).
ayudante(alf).
ayudante(nitu).
ayudante(ignacio).
ayudante(clara).
ayudante(hugo).

noCazaUna(loMagiosDeTempeley).
noCazaUna(losExDePepita).

diaDelAñoActual(192).
%punto 1
esDificil(robarseBorrador(_, turnoNoche)).
esDificil(corregirTp(_, Grupo, objetos)) :- noCazaUna(Grupo).
esDificil(corregirTp(_, Grupo, _)) :- noCazaUna(Grupo).
esDificil(prepararParcial(_)).


vencimiento(corregirTp(FechaEntrega, _, _), FechaVencimiento) :-
    FechaVencimiento is FechaEntrega + 4.

vencimiento(robarseBorrador(DiaClase, _), DiaClase).

estaAtrasada(_, prepararParcial(_)).

estaAtrasada(Persona, Tarea) :-
    vencimiento(Tarea, FechaVencimiento),
    diaDelAñoActual(Hoy),
    Atraso is Hoy - FechaVencimiento,
    Atraso > 3,
    tarea(Persona, Tarea).

ayudantesQueCorrigieron(Grupo, Ayudantes) :-
    tarea(Ayudante, corregirTp(_, Grupo, _)),
    findall(Ayudante, corrigio(Ayudante, _, Grupo), Ayudantes).

corrigio(Ayudante, TP, Grupo) :-
    TP = corregirTp(_, Grupo, _).

%Se agrega la siguiente información a la base de conocimiento:
laburaEnProyectoEnLLamas(alf).
laburaEnProyectoEnLLamas(hugo).
cursa(nitu, [ operativos, diseño, analisisMatematico2 ]).
cursa(clara, [ sintaxis, operativos ]).
cursa(ignacio, [ tacs, administracionDeRecursos ] ).
tienePareja(nitu).
tienePareja(alf).

% A helper has problems if they have a partner
tieneProblemitas(Ayudante) :-
    tienePareja(Ayudante).

% A helper has problems if the project they work on is on fire
tieneProblemitas(Ayudante) :-
    ayudante(Ayudante),
    laburaEnProyectoEnLLamas(Ayudante).

% A helper has problems if they are taking operating systems
tieneProblemitas(Ayudante) :-
    cursa(Ayudante, Cursos),
    member(operativos, Cursos).

alHorno(Ayudante) :-
    ayudante(Ayudante),
    tieneProblemitas(Ayudante),
    forall(tarea(Ayudante, Tarea), estaAtrasada(Ayudante, Tarea)),
    forall(tarea(Ayudante, Tarea), esDificil(Tarea)).

