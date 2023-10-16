import propiedad.*
object provincia {
	const property campos = []
	method agregarcampo(campo){
		campos.add(campo)
	} 
	
	method duenios() {
		return campos.map({campo=>campo.duenioes()})
	}
//	method esmonopolio(){
//		return campos.all(Campo => campo.esduenio(campo.duenio))
//	}

method lamenorinstanciadelaprovincia(){
	return  (campos.sortedBy({ campo1, campo2 => 
	campo1.instancias() < campo2.instancias()})).take(1)
	}
//method duenios() {
//  var dueniosUnicos = campos.distinct().map(campo => campo.esduenio)
//  return dueniosUnicos
//}	
	}
