class Empleado {

	const property habilidades =#{}
	const property misionesRealizadas = #{}
	var property saludActual

	method saludCritica()
	method tengohabilidad(unaHabilidad)
	method HacerMision(unaMision) 

	method estoyIncapacitado() {
		return saludActual < self.saludCritica()
	}
	method puedeUsarHabilidad(unaHabilidad){
		return not self.estoyIncapacitado() && self.tengohabilidad(unaHabilidad)
	}
	method cumpleRequerimiento(habilidadesRequeridas){
		return self.tienenTodasHabilidades(habilidadesRequeridas)
	}
	method tienenTodasHabilidades(habilidadesRequeridas){
		return  habilidadesRequeridas.all({habilidadrequerida => self.puedeUsarHabilidad(habilidadrequerida)})
	}
	method hizoUnaMision(unaMision){
		misionesRealizadas.add(unaMision)
	}
	method recibeDanio(daniodemision){
		saludActual =- daniodemision
	}
}


class Espias inherits Empleado {

	method aprenderNuevaHabilidad(unaHabilidad) {
		habilidades.add(unaHabilidad)
	}

	override method saludCritica() {
		return 15
	}

	override method HacerMision(unaMision) {
	}
	
}

class Oficinista inherits Empleado {

	var estrellas

	override method saludCritica() {
		return 40 - 5 * estrellas
	}

	method sumarEstrella() {
		estrellas = +1
	}

	override method HacerMision(unaMision) {
	}
	override method tengohabilidad(unaHabilidad){
		return habilidades.contains(unaHabilidad)
	}
}

class Jefe inherits Empleado {
	const subordinados = #{}
	override method HacerMision(unaMision) {
	}
	override method tengohabilidad(unaHabilidad){
		return habilidades.contains(unaHabilidad) || subordinados.any({empleado=>empleado.tengoHabiliad(unaHabilidad)})
	}
}
// consultar por logica repetida en este punto como se podria solucionar o es algo que puede pasar sin problema
object equipo {
const property empleadosvarios = #{}

method cumpleRequerimiento(habilidadesRequeridas){
		return empleadosvarios.any({unempleado=>unempleado.tienenTodasHabilidades(habilidadesRequeridas)})
	}
	method hizoUnaMision(unaMision){
		empleadosvarios.forEach({unEmpleado => unEmpleado.hizoUnaMision(unaMision)})
	}
	method recibeDanio(daniodemision){
		empleadosvarios.forEach({unEmpleado => unEmpleado.recibeDanio(daniodemision*0.33333	)})
	}
}

