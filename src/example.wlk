
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
	const tipo
	const property numero
    method obtenerNumero() {
      return numero
   }
   
   method paso(unJugador){
   	if(self.tipocasillero() == "salida" ){
   		unJugador.hacerpago(5000)
   	}
   	
   }
   
   method tipocasillero()=tipo

   
   
}

class PremioGanadero inherits Casillero{
	method cayo(unJugador){
		unJugador.recibipago(2500)
	}
}

class Salida inherits Casillero {
	method cayo(unJugador){
		
	}
}

