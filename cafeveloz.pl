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
% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina).
sustanciaProhibida(cocaina).

% a

% b. pedemonti toma todo lo que toma chamot y lo que toma Maradona
toma(pedemonti, Sustancia) :-
    jugador(pedemonti), 
    (toma(chamot, Sustancia) ; toma(maradona, Sustancia)).

% c. basualdo no toma coca cola
toma(basualdo, Sustancia) :-
    jugador(basualdo),
    Sustancia \= producto(cocacola, _).


% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3). 
maximo(gatoreit, 1).
maximo(naranju, 5).

composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).

