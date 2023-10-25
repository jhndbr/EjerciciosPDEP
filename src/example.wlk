import jugador.*
import campo.*
import propiedad.*
import jugador.*
import campo.*
import empresa.*

class Juego {

	const property jugadores = []
	var property estaTerminado = false

	method empezar() {
		if (not self.estaTerminado()) {
			jugadores.forEach{ jugador => self.queJuegue(jugador)}
		}
	}

	method queJuegue(unJugador) {
		unJugador.moverseSobreCasilleros(unJugador.tirodado(DADOS))
		//unJugador.cayo(unJugador.casilleroactual())
	}

}

class Tablero {

	const property casilleros = []

	method casillerosDesdeHasta(unCasillero, unNumero) {
		return self.casillerosDesde(casilleros.copy(), unCasillero).take(unNumero)
	}

	method casillerosDesde(unosCasilleros, unCasillero) {
		const primero = unosCasilleros.first()
		unosCasilleros.remove(primero) // Remueve el primero
		unosCasilleros.add(primero) // Lo agrega al final
		return if (primero == unCasillero) unosCasilleros else self.casillerosDesde(unosCasilleros, unCasillero)
	}

}

class Casillero {
	
	method paso(unJugador) {
		}
	
	method cayo(unJugador){
		
	}
}

class CasilleroPropiedad inherits Casillero{
	var property propiedadencasillero
	 method propiedadCasillero() {
		return propiedadencasillero
	}
	override method cayo(unJugador){
		
	}
	
}

class PremioGanadero inherits Casillero {

	override method cayo(unJugador) {
		unJugador.recibirPago(2500)
	}

}

class Salida inherits Casillero {

	override method cayo(unJugador) {
	}
	override method paso(unJugador) {
			unJugador.hacerpago(5000)
	}
}

