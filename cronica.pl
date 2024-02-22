protagonista(amigazo).
protagonista(zulemaLogato).
protagonista(hellMusic).
protagonista(ogiCuenco).
protagonista(elGigolo).
talento(amigazo, hablar(ceceoso)).
talento(amigazo, desmayarse).
talento(zulemaLogato, actuar).
talento(zulemaLogato, cantar(20, [teatro])).
talento(hellMusic, cantar(30, [deathMetal, rock])).
talento(hellMusic, hablar(ingles)).
talento(ogiCuenco, actuar).

% entrevista(Protagonista, Dia, Gente)
entrevista(amigazo, jueves, 1500).
entrevista(amigazo, sabado, 14500).
entrevista(hellMusic, lunes, 200).
entrevista(hellMusic, martes, 70000).
% entrevista(Protagonista, Dia, Gente)
entrevista(zulemaLogato, domingo, 100000).

talentoOculto(Protagonista, Talento) :-
    protagonista(Protagonista),
    talento(Protagonista, Talento),
    not(entrevista(Protagonista, _, _)).

mutifacetico(Protagonista) :-
    protagonista(Protagonista),
    talento(Protagonista, Talento1),
    talento(Protagonista, Talento2),
    Talento1 \= Talento2.


carisma(Protagonista, Carisma) :-
    protagonista(Protagonista),
    findall(C, (talento(Protagonista, Talento), carismaTalento(Talento, C)), Carismas),
    sum_list(Carismas, Carisma).

carismaTalento(cantar(Estilos), Carisma) :-
    length(Estilos, Cantidad),
    (Cantidad > 1 -> Carisma is Cantidad * 2 ; Carisma is Cantidad).

carismaTalento(actuar, 35).

carismaTalento(hablar(Tipo), Carisma) :-
    (Tipo = ceceoso -> Carisma is 40 + 25 ; Carisma is 40).

carismaTalento(desmayarse, 0).


% fama(Protagonista, Fama)
fama(Protagonista, Fama) :-
    protagonista(Protagonista),
    findall(F, (entrevista(Protagonista, Dia, Gente), carisma(Protagonista, Carisma), famaEntrevista(Dia, Gente, Carisma, F)), Famas),
    sum_list(Famas, Fama).

% famaEntrevista(Dia, Gente, Carisma, Fama)
famaEntrevista(Dia, Gente, Carisma, Fama) :-
    factorFama(Dia, Factor),
    Fama is Gente * Factor * Carisma.

% factorFama(Dia, Factor)
factorFama(Dia, 0.5) :- esFinDeSemana(Dia).
factorFama(Dia, 0.1) :- not(esFinDeSemana(Dia)).

% esFinDeSemana(Dia)
esFinDeSemana(sabado).
esFinDeSemana(domingo).


% masCarismaSinTalento(Talento, Persona)
masCarismaSinTalento(Talento, Persona) :-
    findall(Carisma, (protagonista(P), carisma(P, Carisma), not(talento(P, Talento))), ListaCarismas),
    max_member(MaxCarisma, ListaCarismas),
    carisma(Persona, MaxCarisma).


% seLaPudre(Persona1, Persona2)
seLaPudre(Persona1, Persona2) :-
    bronca(Persona1, Persona2).
seLaPudre(Persona1, Persona2) :-
    amigo(Persona1, Amigo),
    seLaPudre(Amigo, Persona2).

amigo(zulemaLogato, inia).
amigo(hellMusic, martin).
amigo(amigazo, cappe).
amigo(amigazo, edu).
amigo(inia, martin).
amigo(martin, ogiCuenco).
bronca(samid, viale).
bronca(martin, amigazo).
bronca(ogiCuenco, mirtaLagrande).

