import example.*

object papa {

	const valorNutricional = 1500

	method puedeSerPlantadaEn(terreno) {
	// puede ser plantado en todos los terrenos 
	}

	method valorNutricional(terreno) {
		if (terreno.esRico()) {
			return valorNutricional * 2
		} else {
			return valorNutricional
		}
	}

	method precioDeVenta() {
		return valorNutricional / 2
	}

}

class Algodon {

	method valorNutricional(terreno) {
		return 0
	}

	method precioDeVenta() {
		return 500
	}

	method puedeSerPlantadaEn(terreno) {
		if (not (terreno.esRico())) {
			self.error("no es terreno rico")
		}
	}

}

class Arboles {

	var edad
	var fruta

	method precioDeVenta() {
		return fruta.precio()
	}

	method valorNutricional(terreno) {
		return (self.plusPrecio() * edad).min(self.maximo())
	}

	method plusPrecio()

	method puedeSerPlantadaEn(terreno)

	method maximo()

}

class PalmerasTropicales inherits Arboles {

	override method valorNutricional(terreno) {
		return self.plusPrecio() * edad
	}

	override method plusPrecio() {
		return 2
	}

	override method puedeSerPlantadaEn(terreno) {
		if (not (terreno.esRico())) {
			self.error("no es terreno rico")
		}
	}

	override method maximo() {
		return 7500
	}

	override method precioDeVenta() {
		return fruta.precio() * 5
	}

}

class ArbolesComun inherits Arboles {

	override method plusPrecio() {
		return 3
	}

	override method puedeSerPlantadaEn(terreno) {
		terreno.aptoParaPlanacion()
	}

	override method maximo() {
		return 4000
	}

}

class Fruta {

	const precio

	method precio() = precio

}








