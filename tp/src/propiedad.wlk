import example.*
import jugador.*
import campo.*
import empresa.*

const BANCO = new Banco(nombre = "Banco")

class Propiedad inherits CasilleroPropiedad {
	const property duenio = BANCO
	 const property precioinicial = 1
 	method espropiedad()=true
 	method duenioes() = duenio.nombrees()
 	method dueniopropiedad()= duenio
 	method precioinicialpropiedad()= precioinicial	
 	
	method rentaPara(unJugador){
		return null
	}
	override method propiedadCasillero(){
		return null
	}
	
override method cayo(unJugador){
   			if(self.dueniopropiedad() == BANCO){
   			BANCO.hacerquecompre(unJugador,self.propiedadCasillero())
   			}
   		else if (	self.dueniopropiedad() == unJugador.esmipropiedad( self.propiedadCasillero() ) )
   			{
   			
   			}
   		else{
   			unJugador.pagarAcreedor((self.dueniopropiedad()),(self.rentaPara(unJugador)))
   			}
   		
   	}  
}