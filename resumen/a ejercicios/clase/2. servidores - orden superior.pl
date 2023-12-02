/* Servidores
Práctica Lógico, Predicados de Orden Superior Functores

Un grupo de fanáticos coleccionistas almacenan en servidores gran cantidad de películas, fotos, y libros. 
Las películas se representan con un functor de la forma pelicula(nombre,director,listaActores),
la foto con un functor foto(nombrePersona, anio), y los libros con un functor libro(nombreLibro, autor, idioma).
*/

% almacena(server, listaDeCosas).

almacena(castor, 
	[foto(maradona, 1984), 
	 pelicula(perfumeDeMujer, martinBrest, [alPacino, gabrielleAnwar]), 
	 libro(elTunel, sabato, espaniol), 
	 libro(rayuela,cortazar, espaniol),
	 libro(antesDelFin, sabato, espaniol)]).

almacena(lyrix, 
	[libro(elTunel, sabato, espaniol),
	 foto(maradona, 1984), 
	 pelicula(misionImposible, brianDePalma, [emanuelleBeart, tomCruise]), 
	 libro(ilusiones, richardBatch, ingles), 
	 foto(tomCruise, 1989),
	 foto(johnKennedy, 1954)]).

almacena(rouge, 
	[foto(johnKennedy, 1954), 
	 libro(elTunel, sabato, espaniol), 
	 libro(antesDelFin,sabato, espaniol),
	 foto(maradona, 1984), 
	 pelicula(elDilema, michaelMann, [alPacino,russelCrowe,dianeVerona])]).

pertenece(Cosa, Servidor):- almacena(Servidor, Lista), member(Cosa, Lista).
cosa2(Cosa):- pertenece(Cosa, _).
cosa(Cosa):- setof(C, S ^ pertenece(C,S), L), member(Cosa, L).
servidor(S):- almacena(S, _).

/* 1) Relacionar una cosa determinada libro, foto, película con una lista de servidores en donde esta.
?estaEn(Cosa, Servidores).
Cosa = foto(maradona, 1984);
Servidores = [castor, lyrix, rouge] ; ... */

esta_en(Cosa, Servidores):- cosa(Cosa), findall(S, pertenece(Cosa, S), Servidores).


/* 2) Determinar si un libro, película o foto esta en todos los servidores. 
?estaEnTodos(Cosa). Cosa = libro(elTunel, sabato, espaniol) ; Cosa = foto(maradona, 1984); */

esta_en_todos(Cosa):- cosa(Cosa), forall(servidor(Servidor), pertenece(Cosa, Servidor)).

esta_en_todos2(Cosa):- findall(Servidor, almacena(Servidor, _), Lista), forall(member(S, Lista), pertenece(Cosa, S)).


/* 3) Relacionar un nombre de autor con todos los títulos de sus libros de todos los servidores.
?todosLosLibros(Autor, TitulosLibros).
Autor = sabato, TitulosLibros = [antesDelFin, elTunel] ; */

autor_libros(Autor, Libros):- autor(Autor), findall(Titulo, libro_autor(Titulo, Autor), Libros).

libro_autor(Libro, Autor):- cosa(libro(Libro, Autor, _)).
autor(Autor):- libro_autor(_, Autor).


/* 4) Obtener todas las cosas que no están en un servidor determinado pero si está en el resto de los servidores.
?estaEnTodosExcepto(Cosa, Servidor).
Cosa = foto(johnKennedy, 1954), Servidor = castor ; ....... */

todos_excepto(Cosa, Servidor):- cosa(Cosa), servidor(Servidor), not(pertenece(Cosa, Servidor)), 
	forall((servidor(S), S \= Servidor), pertenece(Cosa, S)).


/* 5) Relacionar un servidor con la foto más antigua que tenga almacenado.
fotoMasAntigua(lyrix,Foto).
Foto=foto(johnKennedy, 1954); */

foto_mas_antigua(Servidor, foto(Nombre, Anio)):- pertenece(foto(Nombre, Anio), Servidor), forall(pertenece(foto(_, A), Servidor), Anio =< A).

/* 6) Un servidor tiene información congruente:
a) Si tiene al menos una película con al menos la foto de alguno de sus actores.
b) O si tiene al menos un libro con la foto de dicho escritor.
?tieneInformacionCongruente(Server).
Server= lyris; */

congruente(Servidor):- pertenece(pelicula(_, _, Actores), Servidor), pertenece(foto(Persona, _), Servidor), member(Persona, Actores).
congruente(Servidor):- pertenece(libro(_, Autor, _), Servidor), pertenece(foto(Autor, _), Servidor).

congruente2(Servidor):- servidor(Servidor), cumple(Servidor).

cumple(Servidor):- pertenece(pelicula(_, _, Actores), Servidor), pertenece(foto(Persona, _), Servidor), member(Persona, Actores).
cumple(Servidor):- pertenece(libro(_, Autor, _), Servidor), pertenece(foto(Autor, _), Servidor).


/* 7) Un servidor puede compartir su contenido si tiene más de 3 cosas valiosas.
?puedeCompartir(Servidor).
Servidor = rouge;
Una determinada foto, película o libro se considera valiosa, si cumple estas condiciones: 
Foto es valiosa si es del año 1960 o anterior. 
Película es valiosa si actúa Al Pacino. 
Libro es valioso si lo escribió Sabato. */

puede_compartir(Servidor):- servidor(Servidor), 
	findall(Cosa, (pertenece(Cosa, Servidor), es_valiosa(Cosa)), Lista), length(Lista, N), N > 3.

es_valiosa(foto(_, Anio)):- Anio =< 1960.
es_valiosa(pelicula(_, _, Actores)):- member(alPacino, Actores).
es_valiosa(libro(_, sabato, _)).