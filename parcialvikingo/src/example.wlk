import tipodevikingo.*
class Vikingo  {
	var tipoDeVikingo 
	
	}


class Soldaddo inherits Vikingo 
{
	var vidascobradas
	const armas =[]
	method armas()=armas
	
	method esProductivo (){
		return not tipoDeVikingo.soyjarlconarma(self)  and (vidascobradas >20 and armas.size() >0)
	}
}

class Granjero inherits Vikingo 
{
	var cantidaddehijos
	var hectareasparaalimentar
	
	method esProductivo (){
		return hectareasparaalimentar/cantidaddehijos >2
	}
}

