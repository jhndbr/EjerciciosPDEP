class Raton {
	var dinero
	const inversiones =#{}
	
	method mealcanza(valor){
		return dinero > valor
	}
	
	
}
class Coleccion {
    const elementos = #{}
    method totalValor() {
        return elementos.map({elemento => elemento.valor()}).sum()
    }
    
    method involucrados(){
    	return elementos 
    }
}

class ComprarCompania inherits Coleccion {
    const porcentaje
    override method totalValor() {
        return self.totalValor() * porcentaje
    }
    
}

class Pelicula {
    const recaudacion
    method valor() {
        return recaudacion
    }
}

class ConstruirParque inherits Coleccion {
    const cantidadDeMetros
    method valorTerreno() {
        return cantidadDeMetros * metrosuelo.valor() * inflacion.valor()
    }
    override method totalValor() {
        return self.totalValor() + self.valorTerreno()
    }
}

class ProducirPelicula inherits Coleccion {
    const costoproduccion
    override method totalValor() {
        return self.totalValor() + costoproduccion
    }
}

class Personaje {
    const sueldo
    method valor() {
        return sueldo
    }
}

class PeliculaIndependiente inherits ProducirPelicula {
    override method totalValor() {
        return self.personasConMasSueldo(4).map({personaje => personaje.valor()}).sum() + costoproduccion
    }
    method personasConMasSueldo(cantidad) {
        return elementos.sortedBy({a, b => a.valor() > b.valor()}).take(cantidad)
    }
}

object inflacion {
    const inflacion = 1.5
    method valor() {
        return inflacion
    }
}

object metrosuelo {
    const precio = 1000
    method valor() {
        return precio
    }
}


/// pregunstar si esta bien usado super o como se podria hacer