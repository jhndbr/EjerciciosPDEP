import example.*
import jugador.*
import propiedad.*
import empresa.*

object provincia {
	const property campos = []
	method agregarcampo(campo){
		campos.add(campo)
		
	} 
	
	method duenios() {
		return campos.map({campo=>campo.duenioes()}).withoutDuplicates()
	}
	
	
	method esmonopolio(){
		return campos.size() > 1 && self.duenios().size() == 1 
	}


	method construccionpareja (campoconstruir){
		return campoconstruir.instanciasconstruidas() <= self.lamenorinstanciadelaprovincia().instanciasconstruidas()
	}
	
	method lamenorinstanciadelaprovincia(){
	return  (campos.sortedBy({ campo1, campo2 => 
	campo1.instanciasconstruidas() < campo2.instanciasconstruidas()})).first()
	}
	
	method sepuedeconstruir(campoconstruir){
		return self.esmonopolio() && self.construccionpareja(campoconstruir)
	}
	}

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
   		duenio.pagarAcreedor(costoConstruccionEstancia)
   		BANCO.recibirPago(costoConstruccionEstancia)
   	}
  }
}
