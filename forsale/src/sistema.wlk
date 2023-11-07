class Sistema{
	const operaciones =[]
	const empleados =[]

	
	method elmejorempleado(){ 
		if (self.lamejorcomision()==self.masoperaciones() ==self.masreservas()) {
			return self.lamejorcomision()
		}
		else {
			throw nohaymejorempleado
		}
		
	}
	
	method lamejorcomision() {
		return empleados.max({unempleado => unempleado.totalcomision()})
	}
	method masoperaciones() {
		return empleados.max({unempleado => unempleado.totaloperacion()})
	}
	method masreservas () {
		return empleados.max({unempleado => unempleado.reservas()})
	}
	
	
	method problema
	
}

class Empleado inherits Sistema{
	var totalcomision 
	const operacionesempleado = []
	const reservas = #{}
	var zonasvendidas = #{}
	
	method concretaroperacion (uninmueble){
		totalcomision =+ uninmueble.inmueblecomision()
		operacionesempleado.add(uninmueble)
		operaciones.add(uninmueble)
	}
	
	method reservarinmueble (inmueble){
		reservas.add(inmueble)
		inmueble.reservado(true)
	}
	method operacionesempleado()=operacionesempleado
	method totalcomision()=totalcomision
	method totaloperacion()= operacionesempleado.size()
	method reservas()=reservas.size()
	method zonasvendidas() = operacionesempleado.map({inmueble => inmueble.zona()}).asSet()
	
	method problemaconotro(otroempleado)
	{	
		return not zonasvendidas.intersection(otroempleado.zonasvendidas()).isEmpty() and  not reservas.intersection(otroempleado.operacionesempleado()).isEmpty()
		
	}
}

const nohaymejorempleado = new DomainException(message = "no se encontro un mejor empleado")