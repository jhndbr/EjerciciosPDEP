/* gustos cinefilos */

actua(diCaprio,titanic).
actua(diCaprio,atrapameSiPuedes).
actua(diCaprio,gilbertGrape).
actua(jeanReno,elProfesional).
actua(tom_hanks, forrest_gump).

genero(titanic,drama).
genero(gilbertGrape,drama).
genero(atrapameSiPuedes,comedia).
genero(ironMan,accion).
genero(rapidoYFurioso,accion).
genero(elProfesional,drama).


le_copa(juan, Peli):- genero(Peli, accion).
le_copa(juan, Peli):- actua(jeanReno, Peli).

le_copa(maria, Peli):- genero(Peli, drama), Peli \= elProfesional, actua(diCaprio, Peli).
le_copa(maria, forrest_gump).

le_copa(jose, Peli):- genero(Peli, drama), not(actua(diCaprio, Peli)).

/*
le_copa(juan, Peli).
le_copa(Alguien, gilbertGrape).
le_copa(maria, Peli), le_copa(jose, Peli)

*/