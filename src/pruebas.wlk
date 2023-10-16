object Persona {
    const property dinero = 1000

    method pagarAcreedor(acreedor, suma) {
        if (self.dinero >= suma) {
            dinero -= suma
            dinero += suma
        } else {
            throw "No tienes suficiente dinero para pagar."
        }
    }
}

const juan = new Persona()
const pedro = new Persona()

juan.pagarAcreedor(pedro, 200)
println("Juan tiene $" + juan.dinero)
println("Pedro tiene $" + pedro.dinero)