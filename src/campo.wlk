import propiedad.*
object provincia {
	const property campos = []
	method agregarcampo(campo){
		campos.add(campo)
		
	} 
	
	method duenios() {
		return campos.map({campo=>campo.duenioes()}).withoutDuplicates()
	}
	
	
	method esmonopolio(){
		return campos.size() > 1 && self.duenios().size() == 1 
	}


	method construccionpareja (campoconstruir){
		return campoconstruir.instanciasconstruidas() <= campos.lamenorinstanciadelaprovincia().instanciasconstruidas()
		
	}
	method lamenorinstanciadelaprovincia(){
	return  (campos.sortedBy({ campo1, campo2 => 
	campo1.instanciasconstruidas() < campo2.instanciasconstruidas()})).first()
	}
	
	method sepuedeconstruir(campoconstruir){
		return self.esmonopolio() && self.construccionpareja(campoconstruir)
	}
	}

	