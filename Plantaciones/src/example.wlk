class Granja {
	const cultivos = #{}
	method medidaNutricional(){
		return cultivos.map({cultivo=> cultivo.valorNutricional()}).sum()
	}
	
	method plantar(planta,terreno){
		
	}
}

class CamposAbierto {
	var tamanio
	
	const sueloRiquezas 
	
	method costoDeMantenimiento()= tamanio * 500
	method permitePlantar()= tamanio * 4
	
	method eaRico(){
		return sueloRiquezas > 100 
	}
	
}

class Invernadero {
	var tamanio
	var property permitePlantar
	const dispositivoCiudado
	const cultivos = #{}
	method costoDeMantenimiento()= 50000 + dispositivoCiudado.mantenimientoDispositivo()
	method eaRico(){
		return cultivos.size() / permitePlantar >2 or dispositivoCiudado.requerimientoSuelo()
	}
}
