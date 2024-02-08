%tarea(Nivel, buscar(Cosa, Ciudad))
tarea(basico,buscar(libro,jartum)).
tarea(basico,buscar(arbol,patras)).
tarea(basico,buscar(roca,telaviv)).
tarea(intermedio,buscar(arbol,sofia)).
tarea(intermedio,buscar(arbol,bucarest)).
tarea(avanzado,buscar(perro,bari)).
tarea(avanzado,buscar(flor,belgrado)).

nivelActual(pepe,basico).
nivelActual(lucy,intermedio).
nivelActual(juancho,avanzado).

idioma(alejandria,arabe).
idioma(jartum,arabe).
idioma(patras,griego).
idioma(telaviv,hebreo).
idioma(sofia,bulgaro).
idioma(bari,italiano).
idioma(bucarest,rumano).
idioma(belgrado,serbio).
habla(pepe,bulgaro).
habla(pepe,griego).
habla(pepe,italiano).
habla(juancho,arabe).
habla(juancho,griego).
habla(juancho,hebreo).
habla(lucy,griego).
capital(pepe,1200).
capital(lucy,3000).
capital(juancho,500).

%participantes(Ps):- findall(P, nivelActual(P,_), Ps).
%participante(P):- participantes(Ps), member(P, Ps).
participante(P):- nivelActual(P,_).

% a
destino_posible(Persona, Ciudad):- nivelActual(Persona, Nivel), tarea(Nivel, buscar(_, Ciudad)).

idioma_util(Nivel, Idioma):- tarea(Nivel, buscar(_, Ciudad)), idioma(Ciudad, Idioma).

% b
excelente_companiero(P1, P2):- participante(P1), participante(P2),
	findall(C, destino_posible(P1,C), Ciudades), forall((member(Ciudad, Ciudades), idioma(Ciudad, Idioma)), habla(P2, Idioma)).

% c
interesante(Nivel):- nivel(Nivel), cumple_condicion(Nivel).

cumple_condicion(Nivel):- forall(tarea(Nivel, buscar(Cosa, _)), viva(Cosa)).
cumple_condicion(Nivel):- tarea(Nivel, buscar(_, Ciudad)), idioma(Ciudad, italiano).
cumple_condicion(Nivel):- findall(Capital, (nivelActual(P, Nivel), capital(P, Capital)), Capitales), sum_list(Capitales, Sum), Sum > 10000.

nivel(Nivel):- nivelActual(_, Nivel).
viva(perro). viva(arbol). viva(flor).

% d
complicado(Persona):- participante(Persona), not((destino_posible(Persona, Ciudad), idioma(Ciudad, Idioma), habla(Persona, Idioma))).
complicado(Persona):- nivelActual(Persona, Nivel), Nivel \= basico, capital(Persona, Capital), Capital < 1500.
complicado(Persona):- nivelActual(Persona, basico), capital(Persona, Capital), Capital < 500.

% e
homogeneo(Nivel):- nivel(Nivel), cosas(Nivel, Cosas), unico_elemento(Cosas).

cosas(Nivel, Cosas):- findall(Cosa, tarea(Nivel, buscar(Cosa, _)), Cosas).

unico_elemento([_]).
unico_elemento([A,A|Resto]):- unico_elemento([A|Resto]).

% f
poliglota(Persona):- participante(Persona), findall(I, habla(Persona, I), Is), length(Is, N), N >= 3.