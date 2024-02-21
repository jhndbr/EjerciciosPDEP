% mensaje(ListaDePalabras, Receptor).
%	Los receptores posibles son:
%	Persona: un simple átomo con el nombre de la persona; ó
%	Grupo: una lista de al menos 2 nombres de personas que pertenecen al grupo.
mensaje(['hola', ',', 'qué', 'onda', '?'], nico).
mensaje(['todo', 'bien', 'dsp', 'hablamos'], nico).
mensaje(['q', 'parcial', 'vamos', 'a', 'tomar', '?'], [nico, lucas, maiu]).
mensaje(['todo', 'bn', 'dsp', 'hablamos'], [nico, lucas, maiu]).
mensaje(['todo', 'bien', 'después', 'hablamos'], mama).
mensaje(['¿','y','q', 'onda', 'el','parcial', '?'], nico).
mensaje(['¿','y','qué', 'onda', 'el','parcial', '?'], lucas).

% abreviatura(Abreviatura, PalabraCompleta) relaciona una abreviatura con su significado.
abreviatura('dsp', 'después').
abreviatura('q', 'que').
abreviatura('q', 'qué').
abreviatura('bn', 'bien').
abreviatura('bn', 'bueno').

% signo(UnaPalabra) indica si una palabra es un signo.
signo('¿').    signo('?').   signo('.').   signo(','). 

% filtro(Contacto, Filtro) define un criterio a aplicar para las predicciones para un contacto
filtro(nico, masDe(0.5)).
filtro(nico, ignorar(['interestelar'])).
filtro(lucas, masDe(0.7)).
filtro(lucas, soloFormal).
filtro(mama, ignorar(['dsp','paja'])).

% recibioMensaje(Persona, Mensaje)
recibioMensaje(nico, mensaje).
recibioMensaje(lucas, mensaje).
recibioMensaje(maiu, mensaje).
recibioMensaje(mama, mensaje).

% demasiadoFormal(Mensaje)
demasiadoFormal(Mensaje) :-
    mensaje(Mensaje, _),
    length(Mensaje, Cantidad),
    Cantidad > 20,
    member('¿', Mensaje),
    not(tieneAbreviaturas(Mensaje)).

% tieneAbreviaturas(Mensaje)
tieneAbreviaturas(Mensaje) :-
    member(Palabra, Mensaje),
    atom_length(Palabra, Longitud),
    Longitud < 4.

% esAceptable(Persona, Palabra, Filtros)
esAceptable(Persona, Palabra, Filtros) :-
    forall(member(Filtro, Filtros), pasaFiltro(Persona, Palabra, Filtro)).

% pasaFiltro(Persona, Palabra, Filtro)
pasaFiltro(Persona, Palabra, masDe(N)) :-
    tasaUso(Persona, Palabra, Tasa),
    Tasa > N.

pasaFiltro(_, Palabra, ignorar(ListaDePalabras)) :-
    not(member(Palabra, ListaDePalabras)).

pasaFiltro(_, Palabra, soloFormal) :-
    demasiadoFormal(Mensaje),
    member(Palabra, Mensaje).

% tasaUso(Persona, Palabra, Tasa)
% Agrega aquí el código para calcular la tasa de uso de una palabra.

% mensajeFormal(Mensaje)
% Agrega aquí el código para obtener los mensajes formales.