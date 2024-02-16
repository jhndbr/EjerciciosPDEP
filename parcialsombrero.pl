mago(harry).
sangre(harry, mestiza).
caracteristica(harry, corajudo).
caracteristica(harry, amistoso).
caracteristica(harry, orgulloso).
caracteristica(harry, inteligente).
odia(harry, slytherin).

mago(draco).
sangre(draco, pura).
caracteristica(draco, inteligente).
caracteristica(draco, orgulloso).
odia(draco, hufflepuff).

mago(hermione).
sangre(hermione, impura).
caracteristica(hermione, inteligente).
caracteristica(hermione, orgullosa).
caracteristica(hermione, corajuda).
caracteristica(hermione, responsable).

mago(ron).
sangre(ron, pura).
caracteristica(ron, amistoso).
caracteristica(ron, corajudo).

mago(hanna).
sangre(hanna, mestiza).

importante(gryffindor, corajudo).

importante(slytherin, orgulloso).
importante(slytherin, inteligente).

importante(ravenclaw, inteligente).
importante(ravenclaw, responsable).

importante(hufflepuff, amistoso).

caracterApropiado(Mago, Casa) :-
    mago(Mago),
    \+ (importante(Casa, Caracteristica),
    \+ caracteristica(Mago, Caracteristica)).
caracterApropiado1(Mago, Casa) :-
    mago(Mago),
    forall(member(Caracteristica, Caracteristicas), caracteristica(Mago, Caracteristica)).

puedeQuedar(Mago, Casa) :-
    caracterApropiado(Mago, Casa),
    \+ odia(Mago, Casa),
    \+ (sangre(Mago, impura), Casa = slytherin).
