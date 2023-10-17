import example.*
import jugador.*
import campo.*
import propiedad.*

// a que se refiere  son tres en todo el juego que conviene acumularlas, hay que hacer una condicion que no se puede crear mas de 3 o que entre todos los jugadores no puede haber mas de 3 empresas
class Empresa inherits Propiedad {
  const property cantidadEmpresas = 0
  
  method sosEmpresa() = true

  method rentaPara(jugadorQueCayo) {
    return jugadorQueCayo.tirarDados() * 30000 * self.dueniopropiedad().cuantasEmpresas()
  }
}