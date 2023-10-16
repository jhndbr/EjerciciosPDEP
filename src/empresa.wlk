class Empresa inherits Propiedad {
  const property cantidadEmpresas = 0

  method sosEmpresa() {
    return true
  }

  method rentaPara(jugadorQueCayo) {
    return jugadorQueCayo.tirarDados() * 30000 * cantidadEmpresas
  }
}