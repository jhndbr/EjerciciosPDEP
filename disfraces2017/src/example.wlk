import disfraz.*
object fiesta {
    var lugar 
    var fecha 
    const invitados =#{}
method esUnBodrio(){
	return invitados.all({persona=> not persona.conformeConUnTraje()})
	}
	
method invitadoConMejorDisfraz(){
	return invitados.sortedBy({a,b => a.puntajeDisfraz()> b.puntajeDisfraz()}).head()
}
	}


class Invitado {
	var edad
    var disfrazActual 
    const disfracesAnteriores = #{}
    var personalidad 
	method edad()=edad
    method cambiarDisfraz(nuevoDisfraz) {
        // Guardar el disfraz actual como disfraz anterior
        disfracesAnteriores.add(disfrazActual)
        // Cambiar al nuevo disfraz
        disfrazActual = nuevoDisfraz
    }
    method puntajeDisfraz() = disfrazActual.puntosDelDisfraz(self)
    
    method esSexi(){
    	return personalidad.esPersonalidadSexi(self)
    }
    method conformeParaCasiTodos(){
		return disfrazActual.puntosDelDisfraz(self) > 10
	}
}

object alegre {
	method esPersonalidadSexi(persona){
		return false
	}
}

object taciturnas  {
	method esPersonalidadSexi(persona){
		return persona.edad() < 30
	}
}

class Caprichosa inherits Invitado {
	method conformeConUnTraje(){
		return  self.conformeParaCasiTodos() and self.conformeParaCaprichosos()
	}
	
	method conformeParaCaprichosos(){
		return disfrazActual.nombre().size() % 2 == 0
	}
	
}
class Comun inherits Invitado {
	method conformeConUnTraje(){
		return self.conformeParaCasiTodos()
	}
}

class Pretencioso inherits Invitado {
	method conformeConUnTraje(){
		return disfrazActual.fechaConfeccion() - fechaActual.dia() < 30
	}
}

class Numerologo inherits Invitado {
	var cifraDeterminada
	method conformeConUnTraje(){
		return self.conformeParaCasiTodos() and disfrazActual.puntosDelDisfraz(self) == cifraDeterminada
	}
}



