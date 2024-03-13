class Granja {
	const terrenos = #{}

	method plantar(planta, terreno) {
		terreno.tieneEspacio()
		terreno.puedePlantar(planta)
		terreno.plantar(planta)
	}

}

class Terreno {

	var tamanio
	const cultivos = #{}

	method permitePlantar()

	method esRico()

	method costoDeMantenimiento()

	method mediaNutricional() {
		if (self.cantidadCultivos() == 0) {
			return 0
		} else {
			return self.totalValorNutricionalCultivos(self) / self.cantidadCultivos()
		}
	}

	method totalValorNutricionalCultivos(terreno) {
		return cultivos.sum({ cultivo => cultivo.valorNutricional(terreno) })
	}

	method cantidadCultivos() {
		return cultivos.size()
	}

	method valorNeto() {
		return self.valorTotalTerreno() - self.costoDeMantenimiento()
	}

	method valorTotalTerreno() {
		return cultivos.sum({ cultivo => cultivo.precioDeVenta() })
	}

	method tieneEspacio() {
		if ((self.permitePlantar() == self.cantidadCultivos())) {
			self.error("no tiene espacio")
		}
	}

	method puedePlantar(planta) {
		planta.puedeSerPlantadaEn(self)
	}

	method aptoParaPlanacion() {
	// no hace nada
	}

	method plantar(planta) {
		cultivos.add(planta)
	}

}

class CamposAbierto inherits Terreno {

	const sueloRiquezas

	override method costoDeMantenimiento() = tamanio * 500

	override method permitePlantar() = tamanio * 4

	override method esRico() {
		return sueloRiquezas > 100
	}
	override method aptoParaPlanacion() {
		self.error("no se puede plantar en esta tierra")
	}
}

class Invernadero inherits Terreno {

	var property permitePlantar
	const dispositivoCiudado

	override method costoDeMantenimiento() {
		return 50000 + dispositivoCiudado.mantenimientoDispositivo()
	}

	override method esRico() {
		return not (self.alcanzaMitadCapacidad()) or dispositivoCiudado.tieneHumedadEntre(20, 40)
	}

	method alcanzaMitadCapacidad() {
		return cultivos.size() / permitePlantar > 2
	}
	
}












