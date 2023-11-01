class Persona {
	var property posicion 
	const elementosCerca = []
	var criterio
	var decisiondecomer
	const comidascomidas = []
	method pedirElemento(unComensal,unElemento) {
		criterio.pedirUnElemento(unComensal,unElemento,self)
	}
	
	method elementosCerca()=elementosCerca
	method sepuedecomer(unaComida){
		decisiondecomer.puedocomer(unaComida)
		comidascomidas.add(unaComida)
	}
	
	method toypion(){
		return comidascomidas.any({unacomida=>unacomida.calorias()>500})
	}
}
//rompe encapsulamiento?

object criteriosordos{
		method pedirUnElemento(unComensal,unElemento,elComensal){
		const elemento = unComensal.elementosCerca().take(1)
		elComensal.elementosCerca().addAll(elemento)
		unComensal.elementosCerca().removeAllSuchThat({unelemento=>elemento.contains(unelemento)})
	}
}
object criteriopasatodo{
		method pedirUnElemento(unComensal,unElemento,elComensal){
		const elemento = unComensal.elementosCerca()
		elComensal.elementosCerca().addAll(elemento)
		unComensal.elementosCerca().removeAllSuchThat({unelemento=>elemento.contains(unelemento)})
	}
}
object criteriocambiarposicion{
		method pedirUnElemento(unComensal,unElemento,elComensal){
		elComensal.posicion(unComensal.posicion())
		unComensal.posicion(elComensal.posicion())
	}
}
object criteriopasaelemento{
		method pedirUnElemento(unComensal,unElemento,elComensal){
		const elemento = unComensal.elementosCerca().find({elemento=>elemento == unElemento})
		elComensal.elementosCerca().add(elemento)
		unComensal.elementosCerca().remove(elemento)
	}
}

object vegano{
	method puedocomer(unaComida){
		return not unaComida.escarne()
	}
}
object diabetico{
	var property caloriasaceptables = 500
	method puedocomer(unaComida){
		return unaComida.calorias() < caloriasaceptables
	}
}
object alterado{
	const alternar = [true,false]
	method puedocomer(unaComida){
		return alternar.anyOne()
	}
}
object combinacion{
	method puedocomer(unaComida){
		return not unaComida.escarne() && unaComida.calorias() < 500
	}
}




class BandejaComida{
	var escarne
	const calorias
	const nombre 
	
	method escarne()=escarne
	method calorias()=calorias
}
