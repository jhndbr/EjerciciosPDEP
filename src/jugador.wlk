import example.*
class Gamer{
	const property nombre 
	var property dinero = 10000
	const property propiedades = []
	
	method puedepagar(suma) {
    return dinero >= suma
	}
 	method recibirPago(pago) {
		dinero += pago
	}
	method hacerpago(pago) {
		dinero += pago
	}
	method nombrees()=nombre
	
	method pagarAcreedor(alguien,suma){
    if (self.puedepagar(suma)){
        self.hacerpago(suma)
        alguien.recibirpago(suma)
    } else {
        throw "No tienes suficiente dinero para pagar."
    }
	}
	method agregarPropiedad(unapropiedad){
		propiedades.add(unapropiedad)
	}
	
	method cuantasEmpresas() {
		return propiedades.filter({propiedad=>propiedad.sosEmpresa()}).size()
	} 
	method esmipropiedad(unaPropiedad){
		propiedades.contains(unaPropiedad)
	}
	
}

	

class Jugador inherits Gamer {
  var property casilleroActual = 0

	
	method casilleroactual()= casilleroActual

  	method cayo(unCasillero) {
    unCasillero.cayo(self)
  	}

  	method paso(unCasillero) {
    unCasillero.paso(self)
  	}
 
	method tirodado(dado){dado.Tirardado()}
	
//	method moverseSobreCasilleros(casillerosAMoverse) {
//    casillerosAMoverse.forEach { casillero =>
//      self.paso(casillero)
//    }
//    // Después de recorrer todos los casilleros, actualiza el casillero actual.
//    
//	}
	
	}
	
	object dado{
	const property numerosdado = [1, 2, 3, 4, 5, 6]
	 method Tirardado(){
		return numerosdado.anyOne() + numerosdado.anyOne()
	}
}

class Banco inherits Gamer {
	method hacerquecompre(unJugador,unaPropiedad){
	unJugador.pagarAcreedor(self,unaPropiedad.precioinicialpropiedad())
	unJugador.agregarPropiedad(unaPropiedad)
	}	
}