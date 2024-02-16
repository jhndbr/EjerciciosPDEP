artesano(carlos, cordoba, 2004).
artesano(maria, bariloche, 2000).
artesano(elsa, humahuaca, 1977).
artesania(ceramica, arcilla).
artesania(plateria, metales).
artesania(tejido, lana).
artesania(estampado, tela).

hace(carlos, ceramica).
hace(carlos, plateria).
hace(maria, ceramica).
hace(elsa, tejido).
hace(elsa, estampado).


cuantos( Persona, C):-
    artesano(Persona, _,_),
    findall( A, hace(Persona, A), Lista),
    length(Lista, C).
  