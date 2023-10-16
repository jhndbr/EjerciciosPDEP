import example.*
import jugador.*
import campo.*
class Propiedad {
  const property duenio = new Banco(nombre = "Banco")
   method duenioes() = duenio.nombrees()
//  method esduenio(elduenio){
//  	return duenio == elduenio
//  }
  
//  method deuniobanco(unjugador){
//		unjugador.pagaracreedor(precioinicial)
//		duenio.recibirpago(precioinicial)
//	}
//  method rentapara(jugadorquecayo) {
//    return 0
//  }
//  method caeaqui(unjugador){
//  	if (self.esduenio(banco)){	
//  	} 
//  	}
//  	
}
class Banco inherits Gamer {
	method hacerquecompre(){
	
	}	
}

class Campo inherits Propiedad{
	
  const property precioinicial = 1
  const property valorRentaFijo = 3000
  const property costoEstancia = 1000
//  var property estanciasConstruidas = 0
//  
//  
//  method instancias()=estanciasConstruidas 
//  
//  method rentaPara(jugadorQueCayo) {
//    return estanciasConstruidas * (2**estanciasConstruidas * valorRentaFijo)
//  }
//  
//
//  method construirEstancia() {
//    Implementa la lógica de construcción de estancias aquí
//  }
}