object casa {
	const valorparticular = 10
	method valordeinmueble(inmueble){
		return valorparticular + inmueble.valorpluszona()
	}
}

object ph {
	method valordeinmueble(inmueble){
		return inmueble.tamanio()*14000 + inmueble.valorpluszona()
	}
}

object departamento {
	method valordeinmueble(inmueble){
		return inmueble.cantidaddehambientes()*350000 + inmueble.valorpluszona()
	}
	
}