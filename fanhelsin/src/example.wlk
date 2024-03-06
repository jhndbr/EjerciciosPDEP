class Mounstruo{
	const zonasAtacadas =#{}
	var vitalida
	method velocidad()
	method peligrosidad(){
		return self.velocidad()+ vitalida
	}
	//por practicidad tomo la fecha como un anio asi compraro si fue anios atras atacado
	method esPatetico(){
		return self.atacoZonaDestruida().size()>0
	}
	method atacoZonaDestruida(){
		return zonasAtacadas.filter({zona=>zona.estabaDestruidaAntesDelultimoAtaque()})
	}
}

class HombreLobo inherits Mounstruo{
	const velocidadBase = 30
	override method velocidad(){
		return velocidadBase + vitalida*2
	}
	
}
class Vanpiros inherits Mounstruo{
	var property velocidad = 100
	
}
class Dragones inherits Mounstruo{
	var velocidad
	override method velocidad()= velocidad
}

