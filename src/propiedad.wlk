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

}