%festival(nombre, lugar, bandas, precioBase).

%lugar(nombre, capacidad).

festival(lulapaluza, lugar(hipodromo,40000), [miranda, paulMasCarne, muse], 500).

festival(mostrosDelRock, lugar(granRex, 10000), [kiss, judasPriest, blackSabbath], 1000).

festival(personalFest, lugar(geba, 5000), [tanBionica, miranda, muse, pharrellWilliams], 300).

festival(cosquinRock, lugar(aerodromo, 2500), [erucaSativa, laRenga], 400).


%banda(nombre, año, nacionalidad, popularidad).

banda(paulMasCarne,1960, uk, 70).

banda(muse,1994, uk, 45).

banda(kiss,1973, us, 63).

banda(erucaSativa,2007, ar, 60).

banda(judasPriest,1969, uk, 91).

banda(tanBionica,2012, ar, 71).

banda(miranda,2001, ar, 38).

banda(laRenga,1988, ar, 70).

banda(blackSabbath,1968, uk, 96).

banda(pharrellWilliams,2014, us, 85).


%entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).

% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).


entradasVendidas(lulapaluza,campo, 600).

entradasVendidas(lulapaluza,plateaGeneral(zona1), 200).

entradasVendidas(lulapaluza,plateaGeneral(zona2), 300).


entradasVendidas(mostrosDelRock,campo,20000).

entradasVendidas(mostrosDelRock,plateaNumerada(1),40).

entradasVendidas(mostrosDelRock,plateaNumerada(2),0).

% … y asi para todas las filas

entradasVendidas(mostrosDelRock,plateaNumerada(10),25).

entradasVendidas(mostrosDelRock,plateaGeneral(zona1),300).

entradasVendidas(mostrosDelRock,plateaGeneral(zona2),500).


plusZona(hipodromo, zona1, 55).

plusZona(hipodromo, zona2, 20).

plusZona(granRex, zona1, 45).

plusZona(granRex, zona2, 30).

plusZona(aerodromo, zona1, 25).

estaDeModa(Banda) :-
    banda(Banda, Anio, _, Popularidad),
    Anio >= 2017,
    Popularidad > 70.

esCareta(Festival) :-
    participenAlMenos(Festival, 2),
    not(entradaRazonable(Festival, Entrada)).



participenAlMenos(Festival, CantidadParametro) :-
    festival(Festival, _, Bandas, _),
    findall(Banda, estaDeModa( Banda), Bandas),
    length(Bandas, Cantidad),
    Cantidad > CantidadParametro.


entradaRazonable(Festival,Entrada) :-
    entradasVendidas(Festival, Entrada, _),
    festival(Festival, _, _, PrecioBase),
    cumpleCondiciones(Entrada,Preciobase).


cumpleCondiciones(plateaGeneral(Zona),Preciobase) :-
        plusZona(_, Zona, Plus),
        Plus < Preciobase * 0.1.


cumpleCondiciones(campo, PrecioBase) :-
    festival(Festival, _, Bandas, _),
    popularidadTotal(Bandas, PopularidadTotal),
    PrecioBase < PopularidadTotal.

popularidadTotal(Bandas, PopularidadTotal) :-
    findall(Popularidad, (member(Banda, Bandas), banda(Banda, _, _, Popularidad)), Popularidades),
    sum_list(Popularidades, PopularidadTotal).

cumpleCondiciones(plateaNumerada(_), PrecioBase) :-
    festival(Festival,Lugar(Sitio,Capacidad),Bandas,_),
    popularidadTotal(Bandas, PopularidadTotal),

    (   (findall(Banda, (member(Banda, Bandas), estaDeModa(Banda)), []), PrecioBase < 750)
    ;   (PrecioBase < Capacidad / PopularidadTotal)
    ).

