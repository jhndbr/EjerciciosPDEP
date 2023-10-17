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
	
	method nombrees()=nombre
}

class Jugador inherits Gamer {
  var property casilleroActual = 0

  
 	method pagarAcreedor(suma){
    if (self.puedepagar(suma)){
        dinero -= suma
    } else {
        throw "No tienes suficiente dinero para pagar."
    }
	} 
	
	method casilleroactual()= casilleroActual

  	method cayo(unCasillero) {
    unCasillero.cayo(self)
  	}

  	method paso(unCasillero) {
    unCasillero.paso(self)
  	}
 
	method tirodado(dado){dado.Tirardado()}
	
	method moverseSobreCasilleros(casillerosAMoverse) {
    casillerosAMoverse.forEach { casillero =>
      self.paso(casillero)
    }
    // Después de recorrer todos los casilleros, actualiza el casillero actual.
    
	}
	method agregarPropiedad(unapropiedad){
		propiedades.add(unapropiedad)
	}
	
	method cuantasEmpresas() {
		return propiedades.filter({propiedad=>propiedad.sosEmpresa()}).size()
	}
	}
	
	object dado{
	const property numerosdado = [1, 2, 3, 4, 5, 6]
	 method Tirardado(){
		return numerosdado.anyOne() + numerosdado.anyOne()
	}
}