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
 
	method rentaPara(jugadorQueCayo) {
 		 return estanciasConstruidas * (2**estanciasConstruidas * valorRentaFijo)
	}
  
// esta bien aca, o rompe encapsulamiento
 	method construirEstanciaen(laprovincia,campoconstruir) {
   		if(laprovincia.sepuedeconstruir(campoconstruir)){
   		estanciasConstruidas =+ 1
   		self.dueniopropiedad().pagarAcreedor(costoConstruccionEstancia)
   		BANCO.recibirPago(costoConstruccionEstancia)
   		}
  	}
  
	method cayo(unJugador){
   		if(self.tipocasillero() == "propiedad"  ){
   			if(self.dueniopropiedad() == BANCO){
   			BANCO.hacerquecompre(unJugador,self)
   			}
   		else if (self.dueniopropiedad() == unJugador.esmipropiedad(self)){
   			
   			}
   		else{
   			unJugador.pagarAcreedor(self.dueniopropiedad(),self.rentaPara(unJugador))
   			}
   			} 
   		else {}
   	}  
}
  
