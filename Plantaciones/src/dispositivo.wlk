import example.*

class Dispositivo {

	var costoBase = 50000

	method mantenimientoDispositivo() {
		return costoBase + self.mantenimientoIndividual()
	}

	method mantenimientoIndividual()

	method reducirCosto(valor) {
		costoBase =-valor
	}

	method tieneHumedadEntre(valor1, valor2) {
		return false
	}

}

class ReguladorNutricional inherits Dispositivo {

	override method mantenimientoIndividual() {
		return 2000
	}

}

class Humidificador inherits Dispositivo {

	var property humedadConfigurada

	override method mantenimientoIndividual() {
		if (humedadConfigurada <= 30) {
			return 1000
		} else {
			return 4500
		}
	}

	override method tieneHumedadEntre(valor1, valor2) {
		return humedadConfigurada.between(valor1, valor2)
	}

}

class PanelSolar inherits Dispositivo {

	override method mantenimientoDispositivo() {
		self.reducirCosto(25000)
		return 0
	}

}






