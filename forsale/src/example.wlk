class Inmueble{
	const tamanio
	const cantidaddehambientes
	const tipodeinmueble
	var property zona 
	
	var property reservado = false
	
	method tamanio()=tamanio
	method cantidaddehambientes()=cantidaddehambientes
	method valorpluszona()=zona.valorplus()
	method inmueblecomision()
}

class Alquiler inherits Inmueble {
	const mesescontrato
	
  	override method inmueblecomision(){
  		return tipodeinmueble.valordeinmueble(self)  * mesescontrato / 50000
  	}
}

class Venta inherits Inmueble{
	override method inmueblecomision(){
  		return tipodeinmueble.valordeinmueble(self)  * porcentajeinmueble.valor()
  	}
}

object porcentajeinmueble {

	var property valor = 1.5

}






