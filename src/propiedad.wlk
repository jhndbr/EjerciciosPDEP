import example.*
import jugador.*
import campo.*
import empresa.*

const BANCO = new Banco(nombre = "Banco")

class Propiedad {
	const property duenio = BANCO
 	
 	method asignarduenio(){
 		if (duenio!=null){
 			
 		}
 	}
 	method duenioes() = duenio.nombrees()
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
  const property costoConstruccionEstancia = 1000
  var property estanciasConstruidas = 0
  
 method costoconstruir()=costoConstruccionEstancia 
 method instanciasconstruidas()=estanciasConstruidas 
 method sosEmpresa() = false
 
 method rentaPara(jugadorQueCayo) {
  return estanciasConstruidas * (2**estanciasConstruidas * valorRentaFijo)
}
  

 method construirEstanciaen(laprovincia) {
   	if(laprovincia.sepuedeconstruir()){
   		estanciasConstruidas =+ 1
   		duenio.pagarAcreedor(costoConstruccionEstancia)
   		BANCO.recibirPago(costoConstruccionEstancia)
   	}
  }
}












































