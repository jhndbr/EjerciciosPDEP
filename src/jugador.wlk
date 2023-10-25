import example.*

class Gamer {

	const property nombre
	var property dinero = 10000
	const property propiedades = []

method recibirPago(pago) {
		dinero += pago
	}
method pagarAcreedor(alguien, suma) {
		if (self.puedepagar(suma)) {
			self.hacerpago(suma)
			alguien.recibirPago(suma)
		} else {
			throw "No tienes suficiente dinero para pagar."
		}
	}

	method puedepagar(suma) {
		return dinero >= suma
	}

method hacerpago(pago) {
		dinero += pago
	}	

	

	method nombrees() = nombre

	

	method agregarPropiedad(unapropiedad) {
		propiedades.add(unapropiedad)
	}

	method cuantasEmpresas() {
		return propiedades.filter({ propiedad => propiedad.sosEmpresa() }).size()
	}

	method esmipropiedad(unaPropiedad) {
		propiedades.contains(unaPropiedad)
	}

}
	
class Jugador inherits Gamer {

	var property casilleroActual = 0

	method casilleroactual() = casilleroActual

	method cayo(unCasillero) {
		unCasillero.cayo(self)
	}

	method paso(unCasillero) {
		unCasillero.paso(self)
	}

	method tirodado(dado) {
		dado.Tirardado()
	}

	method moverseSobreCasilleros(casillerosAMoverse) {
		casillerosAMoverse.reverse().drop(1).forEach{ casillero => self.paso(casillero)}
		casillerosAMoverse.reverse().take(1).forEach{ casillero => self.cayo(casillero)}
			// Después de recorrer todos los casilleros, actualiza el casillero actual.
		casilleroActual =+ casillerosAMoverse.size()
	}

}

object dado {

	const property numerosdado = [ 1, 2, 3, 4, 5, 6 ]

	method Tirardado() {
		return numerosdado.anyOne() + numerosdado.anyOne()
	}
}
const DADOS = dado

class Banco inherits Gamer {

	method hacerquecompre(unJugador, unaPropiedad) {
		unJugador.pagarAcreedor(self, unaPropiedad.precioinicialpropiedad())
		unJugador.agregarPropiedad(unaPropiedad)
	}

}

