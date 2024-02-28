import example.*
class Disfraz {

	var nombre
	var fechaConfeccion
	const caracteristicas = #{}
	method nombre() = nombre
	method fechaConfeccion() = fechaConfeccion

	method puntosDelDisfraz(persona) {
		return caracteristicas.map({ caracteristica => caracteristica.puntosDeCaracteristica(persona) }).sum()
	}
}

object gracioso {
	const nivelDeGracia = 1 // esto va del 1 al 10 inicializo por practicidad 
	
	method puntosDeCaracteristica(persona) {
		if (persona.esMayorDe(50)) {
			return nivelDeGracia * 3
		} else {
			return nivelDeGracia
		}
	}

}

object tobara {
	const diaComprado = 1

	method puntosDeCaracteristica(persona) {
		if (diaComprado - fechaActual.dia() >= 2) {
			return 5
		} else {
			return 3
		}
	}
}

object sexis {
	method puntosDeCaracteristica(persona) {
		if (persona.esSexi()) {
			return 15
		} else {
			return 2
		}
	}
}

object caretas {
	var personajeSimulado

	method puntosDeCaracteristica(persona) {
		return personajeSimulado.puntos()
	}
}

object fechaActual {
	var property dia = 1

}

class PersonajeSimulado {

	const nombre
	const puntos

	method puntos() = puntos

}

