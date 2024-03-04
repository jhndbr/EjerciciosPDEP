class Artista {
	var property fanes = 0
	method sumarFans(gente){
		fanes = fanes + gente * self.calidad() /100
	}
	method restarFansPorcentaje(porcentaje){
		fanes = fanes - fanes * 3/100
	}
	
	method calidad()
	
	method estaPegado(){
		return fanes > 20000
	}
}
class Solista  inherits Artista {	
	var property instrumento
	const property estilosMusica =#{}
		
	override method calidad(){
		return estilosMusica.size() + instrumento.calidadInstrumento()
	}	
	
	method instumento(){
		return instrumento.nombre()
	}
}

class Banda  inherits Artista {
	
	const integrantes =#{}
	method SomosBanda() {
		if (self.soloHayUnVocalista()) {
			if (self.estiloComun()) {
				if (integrantes.size() <= 4) {
					throw new Exception(message = "son una banda :)")
				} else {
					throw new Exception(message = "hay mas de 4 integrantes")
				}
			} else {
				throw new Exception(message = "no tienen estilo en comun")
			}
		} else {
			throw new Exception(message = "hay mas vocalistas")
		}
	}
	
	method soloHayUnVocalista(){
		return integrantes.map({artista=>artista.instrumento()== "vocalista"}).size() >1 
	}
	method estiloComun(){
		return self.listaDeEstilos().flatten().asSet().size() < self.listaDeEstilos().flatten().size()
	}
	method listaDeEstilos(){
		return integrantes.map({artista=>artista.estilosMusica()})
	}
	
	method estilosMusica(){
	return self.listaDeEstilos().fold(self.listaDeEstilos().head(), { acum, lista => acum.intersection(lista) })
	}
	override method calidad(){
		return self.estilosMusica().size()*5 + self.calidadAltaIntegrante() + integrantes.size()*2
	}
	
	method calidadAltaIntegrante(){
		return integrantes.sortedBy({a,b => a.calidad()> b.calidad()}).head().calidad()
	}
	override method sumarFans(gente){
		fanes = fanes + gente * self.calidad() /100
		self.sumarFanArtistaMasCalidad(gente)
	}
	method sumarFanArtistaMasCalidad(gente){
		self.artistaMasCalidad().sumarFans(gente)
	}
	method artistaMasCalidad(){
		return integrantes.sortedBy({a,b => a.calidad()> b.calidad()}).head()
	}
}

object guitarra {
	const nombre = "criolla" 
	const calidadInstrumento = 2
	method nombre()=nombre
	method calidadInstrumento()=calidadInstrumento
}
object vocalista {
	const nombre = "vocalista" 
	const calidadInstrumento = 2
	method nombre()=nombre
	method calidadInstrumento()=calidadInstrumento
}

class Recital {
	var artista
	var duracion
	var gente
	
	method seHaceRecital(){
		artista.sumarFans(gente)
		if (duracion<1){artista.restarFansPorcentaje(3)}
	}
	
}
