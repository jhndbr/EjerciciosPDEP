/* Soñaba jugar un mundial */

Colombia, Camerún, Jamaica e Italia
grupo(colombia, a).
grupo(camerun, a).
grupo(jamaica, a).
grupo(italia, a).
grupo(argentina, b).
grupo(nigeria, b).
grupo(japon, b).
grupo(escocia, b).

rival(P1, P2):- grupo(P1, G), grupo(P2, G), P1 \= P2.
