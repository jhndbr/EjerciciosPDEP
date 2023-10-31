import example.*
import jugador.*
import propiedad.*
import empresa.*

class Campo inherits Propiedad{
  const property valorRentaFijo = 3000
  const property costoConstruccionEstancia = 1000
  var property estanciasConstruidas = 0
  
 	method costoconstruir()=costoConstruccionEstancia 
	 method instanciasconstruidas()=estanciasConstruidas 
 	method sosEmpresa() = false
 
	override method rentaPara(jugadorQueCayo) {
 		 return estanciasConstruidas * (2**estanciasConstruidas * valorRentaFijo)
	}
  
// esta bien aca, o rompe encapsulamiento
 	method construirEstanciaen(laprovincia,campoconstruir) {
   		if(laprovincia.sepuedeconstruir(campoconstruir)){
   		estanciasConstruidas =+ 1
   		self.dueniopropiedad().pagarAcreedor(BANCO,costoConstruccionEstancia)
   		}
  	}
  
	
}
  
