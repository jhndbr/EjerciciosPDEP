import example.*
class Lugares{
	const ataques =#{}
	var property diaDestruccion
	method resistencia()
	 
	method nigmareTeam(){
		return ataques.map({ataque=>ataque.mountruoMasPeligroso()}).asSet()
	}
	
	method fueDestruido(ataque){
		diaDestruccion = ataque.fechaAtaque()
		return self.resistencia() < ataque.nivelsDevastacion()
		
	}
	method fechasDeAtaque(){
		return ataques.map({ataque=>ataque.fechaAtaque()})
	}
	
	method estabaDestruidaAntes(fecha){
		return diaDestruccion<fecha
	}
	
	method recibirAtaque(ataque){
			self.PuedeSerAtacado(ataque)
			ataques.add(ataque)
		
	}
	method PuedeSerAtacado(ataque)
}

class Aldea inherits Lugares{
	const casas = []
	override method resistencia(){
		return casas.sum({casa=>casa.resistenciaCasa()})
	}
	override method PuedeSerAtacado(ataque){
		if(not(ataque.ningunoPatetico())) {
			self.error("hay un patetico")
		}
	}
	
}
class Castillo inherits Lugares{
	var resistenciaCastillo
	var guardias
	const resistenciaBase = 3000
	override method resistencia(){
		if (guardias.CantidadDeGuardias()>0){
			return self.resistenciaSinGuardias()+ guardias.resistenciaGuardias()
		}else {
			return self.resistenciaSinGuardias()
		}
	}
	override method PuedeSerAtacado(ataque){
		if(not(ataque.peligrosidadMayorA(256))) {
			self.error("hay un patetico")
		}
	}
	 method resistenciaSinGuardias(){
		return resistenciaCastillo + resistenciaBase
	}
	
}
class Guardias{
	var cantidadDeGuardias
	const plusMago
	const valorEstructura = 20
	method CantidadDeGuardias()=cantidadDeGuardias
	
	method resistenciaGuardias(){
		return plusMago * cantidadDeGuardias.size() + valorEstructura
	}
}

class Ataque {
	const fecha 
	const mounstruos =#{}
	
	method fechaAtaque()=fecha
	method mountruosAtaque()=mounstruos
	
	method mountruoMasPeligroso(){
		return mounstruos.max({mounstruo=>mounstruo.peligrosidad()})
	}
	method cantidadMountruosMasMalos(){
		return self.mounstruosMasMalos().size()
	}
	method mounstruosMasMalos() {
		return mounstruos.filter({mounstruo => mounstruo.esMalo()})
	}
	method AtaqueSerio(unAtaque){
		return unAtaque.cantidadMountruosMasMalos()>3
	}
	method nivelsDevastacion(){
		return mounstruos.sum({mounstruo=>mounstruo.peligrosidad()})
	}
	method ningunoPatetico(){
		return mounstruos.all({mousntruo=>not(mousntruo.esPatetico())})
	}
	method peligrosidadMayorA(numero){
		return mounstruos.all({mousntruo=>mousntruo.peligrosidad()>numero})
	}
	
}

class Casa {
	var resistenciaCasa
	method resistenciaCasa()=resistenciaCasa
}