nacio(ana,1905).
nacio(mercedes,1906).
nacio(juan,1933).
nacio(pepe,1939).
nacio(angel,1958).
nacio(mario,1960).
nacio(lucia,1908).
nacio(nuria,1941).
nacio(marcela,1931).
seCasaron(ana,lucas,1932).
seCasaron(lucia,pepe,1961).
seCasaron(nuria,pepe,1966).
seCasaron(marcela,pepe,1967).
murio(juan,1993,mendoza).
murio(mercedes,1934,tucuman).
murio(angel,1986,rosario).
anioActual(2006).

% edad
edad(Persona, Edad):- nacio(Persona, AnioN), not(murio(Persona, _, _)), anioActual(AnioA), Edad is AnioA - AnioN.
edad(Persona, Edad):- nacio(Persona, AnioN), murio(Persona, AnioF, _), Edad is AnioF - AnioN.

% especial
especial(Persona):- se_caso(Persona, AnioC), edad_en(Persona, AnioC, Edad), rango(Edad).
especial(Persona):- nacio(Persona, _), findall(1, se_caso(Persona, _), L), length(L,N), N >= 3.
especial(Persona):- edad(Persona, Edad), Edad > 100.

se_caso(Persona, Anio):- seCasaron(Persona, _, Anio).
se_caso(Persona, Anio):- seCasaron(_, Persona, Anio).

edad_en(Persona, Anio, Edad):- nacio(Persona, AnioN), Edad is Anio - AnioN.

rango(Edad):- Edad < 18.
rango(Edad):- Edad > 50.

% anio_con_registro anio_feliz
anio_con_registro(Anio):- nacio(_, Anio).
anio_con_registro(Anio):- seCasaron(_, _, Anio).
anio_con_registro(Anio):- murio(_, Anio, _).

anio_feliz(Anio):- anio_con_registro(Anio), not(murio(_, Anio, _)).

% hay_seguidilla
hay_seguidilla(Anio, Duracion):- anio_con_registro(Anio), Anio2 is Anio + 1, hay_seguidilla(Anio2, Duracion2), Duracion is Duracion2 + 1.
hay_seguidilla(Anio, 0):- not(anio_con_registro(Anio)).


