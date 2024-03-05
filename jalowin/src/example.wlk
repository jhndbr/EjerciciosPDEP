class Ninios{
	const elementos =#{}
	var actitud
	var bolsa 
	method bolsa()=bolsa
	method capacidadAsustar(){
		return elementos.map({elemento=>elemento.sustoQueGenera()}).sum()* actitud
	}
	method elementos()=elementos
	method asustar(adulto){
		adulto.seAsusta(self)
	}
	method intercambioCaramelos(caramelos){
		bolsa =+caramelos
	}
	
	method comerCaramelos(cantidad){
		if (bolsa - cantidad < 0 ) { 
			throw new Exception(message = "No hay Caramelos :(")
		}else {bolsa=-cantidad}
	}
}

class Legion {
	const miembros = #{}
	method capacidadAsustar(){
		return miembros.map({ninio=>ninio.capacidadAsustar()}).sum()
	}
	method cantidadCaramelos(){
		return miembros.map({ninio=>ninio.bolsa()}).sum()
	}
	
	method asustar(adulto){
		adulto.seAsusta(self)
	}
	method intercambioCaramelos(caramelos){
		self.miembroMayorCapacidad().intercambioCaramelos(caramelos)
	}
	method miembroMayorCapacidad(){
		return miembros.sortedBy({a,b => a.capacidadAsustar()> b.capacidadAsustar()}).head()
	}
///////////////////////////CONSULTA//////////////////////////////////////////////
//Dado un conjunto de niños, crear una legión. Toda legión debe tener al menos dos
//niños, por lo que la creación debe fallar si no se cumple esta restricción.	
//////////////////////////consulta punto3////////////////////////////////////////
}
class Maquillaje{
	method sustoQueGenera() {
		return 3
	}
}

class Traje{
	const representacion 
	method sustoQueGenera() {
		return representacion
	}
}

const winniePooh = new Traje(representacion = 2)
const sulivan = new Traje(representacion = 2)
const jason = new Traje(representacion = 5)
const george = new Traje(representacion = 5)

// hay logica repetida, puede eliminarse
class AdultosComun {
	var intentos
	method seAsusta(ninio){
		if (self.tolerancia()>ninio.capacidadAsustar()){
			ninio.intercambioCaramelos(self.tolerancia()/2)
		}else {
			self.sumarIntentos()
		}
	}
	method tolerancia (){return 10 * intentos}
	method sumarIntentos(){
		intentos =+1
	}
}
class Abuelo {
	var intentos
	method tolerancia (){return 10 * intentos}
	method seAsusta(ninio){
		ninio.intercambioCaramelos(self.tolerancia()/2)
		self.sumarIntentos()
	}
	method sumarIntentos(){
		intentos =+1
	}
}
class AdultoNecio {
	method seAsusta(ninio){
		
	}
}


class Barrio {
	const ninios=#{}
	// en este caso 3 
	method CantidadConMasCaramelos(cantidad){
		return ninios.sortedBy({a,b => a.bolsa()> b.bolsa()}).take(cantidad)
	}
	method elementosDeniniosConCaramelosMayorA(cantidad){
		return self.caramelosMayorA(cantidad).map({ninio=>ninio.elementos()}).asSet()
	}
	
	method caramelosMayorA(cantidad){
		return ninios.filter({ninio=>ninio.bolsa()>cantidad})
	}
}































