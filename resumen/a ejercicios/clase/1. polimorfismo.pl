%lugar(nombre,hotel(nombre,cantEstrellas,montoDiario)
lugar(marDelPlata, 	hotel(elViajante,4,100)).
lugar(lasToninas, 	hotel(holidays,2,50)).
lugar(tandil,		quinta(amanecer,pileta,80)).
lugar(bariloche,	carpa(70)).
lugar(laFalda, 		casa(pileta,50)).
lugar(rosario, 		casa(garaje,80)).

%puedeGastar(nombre,cantDias,montoTotal).
puedeGastar(ana,    4, 2000).
puedeGastar(hernan, 5, 3500).
puedeGastar(mario,  5, 3000).

puede_ir(Persona, Lugar, Alojamiento):- 
	puedeGastar(Persona, Dias, Presupuesto), lugar(Lugar, Alojamiento),
	cumple_condicion(lugar(_, Alojamiento), MontoDiario),
	MontoDiario * Dias =< Presupuesto.
	
cumple_condicion(lugar(_, hotel(_, Estrellas, MontoDiario)), MontoDiario):- Estrellas > 3.
cumple_condicion(lugar(_, casa(garaje, MontoDiario)), MontoDiario).
cumple_condicion(lugar(_, quinta(_, pileta, MontoDiario)), MontoDiario).
cumple_condicion(lugar(_, carpa(MontoDiario)), MontoDiario).


/*
persona(Persona):- puedeGastar(Persona, _, _).
lugar(Lugar):- lugar(Lugar, _).

puede_ir(Persona, Lugar, Alojamiento):- 
	lugar(Lugar, hotel(_, Estrellas, MontoDiario)), Estrellas > 3, 
	puedeGastar(Persona, Dias, Presupuesto), MontoDiario * Dias =< Presupuesto.

puede_ir(Persona, Lugar, Alojamiento):- 	
	lugar(Lugar, casa(garaje, MontoDiario)),
	puedeGastar(Persona, Dias, Presupuesto), MontoDiario * Dias =< Presupuesto.
	
puede_ir(Persona, Lugar, Alojamiento):- 	
	lugar(Lugar, quinta(_, pileta, MontoDiario)),
	puedeGastar(Persona, Dias, Presupuesto), MontoDiario * Dias =< Presupuesto.
	
puede_ir(Persona, Lugar, Alojamiento):- 	
	lugar(Lugar, carpa(MontoDiario)),
	puedeGastar(Persona, Dias, Presupuesto), MontoDiario * Dias =< Presupuesto.
*/
	