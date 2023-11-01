import example.*
class Misiones {
	const habilidadesRequeridas = #{}
	const daniodemision 
	method hacerMision(ejecutor){
		if(ejecutor.cumpleRequerimiento(habilidadesRequeridas)){
			ejecutor.recibeDanio(daniodemision)
			ejecutor.hizoUnaMision(self)
		}
	}
	// cuando aprende habilidades, si uso set, hace falta filtrar las habilidades que no tiene para que las aprenda?
	// al aprender una habilidad, solo el espia tiene la habiliadda, el jefe y el oficinista deben entender el mensaje y no hacer nada?
	//
}
