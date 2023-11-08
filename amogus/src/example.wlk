object nave{
	const jugadores = #{}
}


class jugadores{
	const color 
	const mochila =[]
	var nivelDeSospecha = 40 
	const tareasarealizar =[]
	
	method essospechoso(){
		return nivelDeSospecha>50
	}
	
	method buscaritem(unitem){
		mochila.add(unitem)
	}
} 

