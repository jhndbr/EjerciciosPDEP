import example.*
import jugador.*
import campo.*
import propiedad.*


class Empresa inherits Propiedad {
  const property cantidadEmpresas = 0

  method sosEmpresa() = true

  method rentaPara(jugadorQueCayo) {
    return jugadorQueCayo.tirarDados() * 30000 * self.duenioes().cuantasEmpresas()
  }
}