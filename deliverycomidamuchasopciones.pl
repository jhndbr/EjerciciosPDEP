%composicion(plato, [ingrediente])%
composicion(platoPrincipal(milanesa),[ingrediente(pan,3),
ingrediente(huevo,2),ingrediente(carne,2)]).
composicion(entrada(ensMixta),[ingrediente(tomate,2),
ingrediente(cebolla,1),ingrediente(lechuga,2)]).
composicion(entrada(ensFresca),[ingrediente(huevo,1),
ingrediente(remolacha,2),ingrediente(zanahoria,1)]).
composicion(postre(budinDePan),[ingrediente(pan,2),ingrediente(caramelo,1)]).


%calorías(nombreIngrediente, cantidadCalorias)%
calorias(pan,30).
calorias(huevo,18).
calorias(carne,40).
calorias(caramelo,170).

%proveedor(nombreProveedor, [nombreIngredientes])%
proveedor(disco, [pan, caramelo, carne, cebolla]).
proveedor(sanIgnacio, [zanahoria, lechuga, miel, huevo]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% aca realizarmos direcamente calorias todales%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
caloriasTotales(Plato, CaloriasTotales) :-
    composicion(entrada(Plato), Ingredientes),
    findall(Calorias, (member(ingrediente(Ingrediente, Cantidad), Ingredientes), calorias(Ingrediente, CaloriasIngrediente), Calorias is CaloriasIngrediente * Cantidad), CaloriasTotalesPorIngrediente),
    sumlist(CaloriasTotalesPorIngrediente, CaloriasTotales).
caloriasTotales(Plato, CaloriasTotales) :-
    composicion(platoPrincipal(Plato), Ingredientes),
    findall(Calorias, (member(ingrediente(Ingrediente, Cantidad), Ingredientes), calorias(Ingrediente, CaloriasIngrediente), Calorias is CaloriasIngrediente * Cantidad), CaloriasTotalesPorIngrediente),
    sumlist(CaloriasTotalesPorIngrediente, CaloriasTotales).
caloriasTotales(Plato, CaloriasTotales) :-
    composicion(postre(Plato), Ingredientes),
    findall(Calorias, (member(ingrediente(Ingrediente, Cantidad), Ingredientes), calorias(Ingrediente, CaloriasIngrediente), Calorias is CaloriasIngrediente * Cantidad), CaloriasTotalesPorIngrediente),
    sumlist(CaloriasTotalesPorIngrediente, CaloriasTotales).


caloriasTotales2(Plato, CaloriasTotales) :-
    composicion(entrada(Plato), Ingredientes),
    calcularCalorias(Ingredientes, CaloriasTotales).

caloriasTotales2(Plato, CaloriasTotales) :-
    composicion(platoPrincipal(Plato), Ingredientes),
    calcularCalorias(Ingredientes, CaloriasTotales).

caloriasTotales2(Plato, CaloriasTotales) :-
    composicion(postre(Plato), Ingredientes),
    calcularCalorias(Ingredientes, CaloriasTotales).

calcularCalorias(Ingredientes, CaloriasTotales) :-
    findall(Calorias, (
        member(ingrediente(Ingrediente, Cantidad), Ingredientes),
        calorias(Ingrediente, CaloriasIngrediente),
        Calorias is CaloriasIngrediente * Cantidad
    ), CaloriasTotalesPorIngrediente),
    sumlist(CaloriasTotalesPorIngrediente, CaloriasTotales).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% aca delegamos en un predicado para q quede mejor %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
caloriasIngrediente(ingrediente(Ingrediente, Cantidad), Calorias) :-
    calorias(Ingrediente, CaloriasIngrediente),
    Calorias is CaloriasIngrediente * Cantidad.

% Calcula las calorías totales de un plato
caloriasTotales1(Plato, CaloriasTotales) :-
    composicion(Plato, Ingredientes),
    findall(Calorias, (member(Ingrediente, Ingredientes), caloriasIngrediente(Ingrediente, Calorias)), CaloriasTotalesPorIngrediente),
    sumlist(CaloriasTotalesPorIngrediente, CaloriasTotales).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Un plato es simpático si incluye pan y huevo entre sus ingredientes
platoSimpatico(Plato) :-
    composicion(Plato, Ingredientes),
    member(ingrediente(pan, _), Ingredientes),
    member(ingrediente(huevo, _), Ingredientes).

% Un plato es simpático si tiene menos de 200 calorías por porción
platoSimpatico(Plato) :-
    caloriasTotales(Plato, CaloriasTotales),
    CaloriasTotales < 200.

% Un menú dietético consiste en una entrada, un plato principal y un postre, cuyas calorías totales no superan las 450
menuDiet(Entrada, PlatoPrincipal, Postre) :-
    esEntrada(Entrada),
    esPlatoPrincipal(PlatoPrincipal),
    esPostre(Postre),
    maplist(caloriasTotales, [Entrada, PlatoPrincipal, Postre], Calorias),
    sum_list(Calorias, CaloriasTotales),
    CaloriasTotales =< 450.

% Tres platos forman un menú diet si: el primero es entrada, el segundo es plato principal, el tercero es postre, y además la suma de las calorías por porción de los tres no supera 450.
menuDiet(Entrada, PlatoPrincipal, Postre) :-
    esEntrada(Entrada),
    esPlatoPrincipal(PlatoPrincipal),
    esPostre(Postre),
    caloriasTotales1(Entrada, CaloriasEntrada),
    caloriasTotales1(PlatoPrincipal, CaloriasPlatoPrincipal),
    caloriasTotales1(Postre, CaloriasPostre),
    CaloriasTotales is CaloriasEntrada + CaloriasPlatoPrincipal + CaloriasPostre,
    CaloriasTotales =< 450.

% Un plato es una entrada si su composición está definida con entrada(_)
esEntrada(Plato) :-
    composicion(entrada(Plato), _).

% Un plato es un plato principal si su composición está definida con platoPrincipal(_)
esPlatoPrincipal(Plato) :-
    composicion(platoPrincipal(Plato), _).

% Un plato es un postre si su composición está definida con postre(_)
esPostre(Plato) :-
    composicion(postre(Plato), _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proveedorDePlato(Plato, CaloriasTotales) :-
    composicion(entrada(Plato), Ingredientes),
    tieneTodosIngredientes(Ingredientes, CaloriasTotales).

proveedorDePlato(Plato, CaloriasTotales) :-
    composicion(platoPrincipal(Plato), Ingredientes),
    tieneTodosIngredientes(Ingredientes, CaloriasTotales).

proveedorDePlato(Plato, CaloriasTotales) :-
    composicion(postre(Plato), Ingredientes),
    tieneTodosIngredientes(Ingredientes, CaloriasTotales).

tieneTodosIngredientes(Ingredientes, Proveedor) :-
    forall(member(ingrediente(Ingrediente, _), Ingredientes), proveedor(Proveedor, Ingrediente)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ingredientePopular(Ingrediente) :-
    composicion(_, Ingredientes),
    findall(Plato, (ingredientesDePlato(Plato, Ingredientes), member(ingrediente(Ingrediente, _), Ingredientes)), Platos),
    length(Platos, N),
    N > 3.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% punto 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cantidadTotal(Ingrediente, Platos, CantidadTotal) :-
    findall(Cantidad, (member(Plato, Platos), ingredientesDePlato(Plato, Ingredientes), member(ingrediente(Ingrediente, Cantidad), Ingredientes)), Cantidades),
    sumlist(Cantidades, CantidadTotal).












%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% predicado que sirve 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proveedorDePlato(Plato, CaloriasTotales) :-
    composicion(TipoPlato, Plato),
    ingredientesDePlato(TipoPlato, Ingredientes),
    tieneTodosIngredientes(Ingredientes, CaloriasTotales).

caloriasTotales2(Plato, CaloriasTotales) :-
    composicion(TipoPlato, Plato),
    ingredientesDePlato(TipoPlato, Ingredientes),
    calcularCalorias(Ingredientes, CaloriasTotales).

ingredientesDePlato(entrada(_), Ingredientes) :-
    composicion(entrada(Plato), Ingredientes).
ingredientesDePlato(platoPrincipal(_), Ingredientes) :-
    composicion(platoPrincipal(Plato), Ingredientes).
ingredientesDePlato(postre(_), Ingredientes) :-
    composicion(postre(Plato), Ingredientes).

tieneTodosIngredientes(Ingredientes, CaloriasTotales) :-
    findall(Calorias, (
        member(ingrediente(Ingrediente, Cantidad), Ingredientes),
        calorias(Ingrediente, CaloriasIngrediente),
        Calorias is CaloriasIngrediente * Cantidad
    ), CaloriasTotalesPorIngrediente),
    sumlist(CaloriasTotalesPorIngrediente, CaloriasTotales).