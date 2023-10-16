// Definición de las clases

class Juego {
  const property jugadores = []
  var property estaTerminado = false

  method empezar() {
    if (not self.estaTerminado()) {
      jugadores.forEach { jugador => self.queJuegue(jugador) }
    }
  }
  method queJuegue(unJugador) {
    unJugador.moverseSobreCasilleros(unJugador.tirarDado())
    unJugador.cayo(unJugador.casilleroactual())
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
    unosCasilleros.add(primero)    // Lo agrega al final
    return if (primero == unCasillero) unosCasilleros 
           else self.casillerosDesde(unosCasilleros, unCasillero)
  }
}

class Casillero {
	const property numero
    method obtenerNumero() {
      return numero
   }
}

class PremioGanadero {}

class Salida {}

