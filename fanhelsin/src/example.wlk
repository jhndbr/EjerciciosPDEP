import lugares.*
class Mounstruo{
	const ataquesRealizados =#{}
	const zonasAtacadas =#{}
	var vitalida
	method velocidad()
	method peligrosidad(){
		return self.velocidad()+ vitalida
	}
	//por practicidad tomo la fecha como un anio asi compraro si fue anios atras atacado
	method esPatetico(){
		return ataquesRealizados.all({ataque=>zonasAtacadas.any({zona=>zona.estabaDestruidaAntes(ataque.fechaAtaque())})})
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

