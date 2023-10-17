import example.*
import jugador.*
import campo.*
import empresa.*

const BANCO = new Banco(nombre = "Banco")

class Propiedad inherits Casillero{
	const property duenio = BANCO
	 const property precioinicial = 1
 	method espropiedad()=true

 	method duenioes() = duenio.nombrees()
 	method dueniopropiedad ()= duenio
 	method precioinicialpropiedad()= precioinicial
 	
 	method cayo(unJugador){
//   	if(self.tipocasillero() == "propiedad"  ){
//   		if(self.dueniopropiedad() == BANCO){
//   			BANCO.hacerquecompre(unJugador,self)
//   		}
//   		else if (self.dueniopropiedad() == unJugador.esmipropiedad(self)){
//   			
//   		}
//   		else{
//   			unJugador.pagarAcreedor(self.dueniopropiedad(),rentaPara(unJugador))
//   		}
//   	}
   }

}







































