class Guerrero {
    var potencialOfensivo
    var nivelDeExperiencia
    var nivelDeEnergia
    var nivelDeEnergiaOriginal
    var traje 
    
    method atacaA(otroGuerrero) {
        otroGuerrero.sufroAtaque(potencialOfensivo)
    }

    method sufroAtaque(potencialAtaque) {
        nivelDeEnergia -= potencialAtaque * 0.1
        nivelDeExperiencia += 1
    }

    method comoSemillaErmitanio() {
        nivelDeEnergia = nivelDeEnergiaOriginal
    }
}




class Traje {
    var desgaste = 0

    method manejarAtaque(guerrero, potencialAtaque) {
        desgaste += 5
        const danioCausado = self.calcularDanio(potencialAtaque)
        guerrero.bajarNivelDeEnergia(danioCausado)
    }

    method calcularDanio(potencialAtaque)

    method estaGastado() {
        return desgaste >= 100
    }
}

class TrajeComun inherits Traje {
    var porcentajeProteccion

    override method calcularDanio(potencialAtaque) {
        if (self.estaGastado()) {
            return potencialAtaque
        }
        return potencialAtaque * (1 - porcentajeProteccion / 100)
    }
}

class TrajeEntrenamiento inherits Traje {
    override method calcularDanio(potencialAtaque) {
        if (self.estaGastado()) {
            return potencialAtaque
        }
        return potencialAtaque * 0.1
    }
}


class Pieza {
    var porcentajeResistencia
    var desgaste = 0

    method estaGastada() {
        return desgaste >= 20
    }
}

class TrajeModularizado inherits Traje {
    var piezas = []

    override method manejarAtaque(guerrero, potencialAtaque) {
        piezas.forEach(pieza => pieza.desgaste += 5)
        const danioCausado = self.calcularDanio(potencialAtaque)
        guerrero.bajarNivelDeEnergia(danioCausado)
        guerrero.aumentarExperiencia(this.calcularIncrementoExperiencia())
    }

    override method calcularDanio(potencialAtaque) {
        if (this.estaGastado()) {
            return potencialAtaque
        }
        const resistenciaTotal = piezas.filter(pieza => !pieza.estaGastada()).map(pieza => pieza.porcentajeResistencia).reduce((a, b) => a + b, 0)
        return potencialAtaque - resistenciaTotal
    }

    method calcularIncrementoExperiencia() {
        const piezasNoGastadas = piezas.filter(pieza => !pieza.estaGastada()).size()
        return piezasNoGastadas / piezas.size()
    }

    override method estaGastado() {
        return piezas.every(pieza => pieza.estaGastada())
    }
}


class Saiyan inherits Guerrero {
    var esSuperSaiyan = false
    var nivelSuperSaiyan = 0
    var energiaOriginal

    method convertirseEnSuperSaiyan(nivel) {
        esSuperSaiyan = true
        nivelSuperSaiyan = nivel
        energiaOriginal = nivelDeEnergia
    }

    method volverAEstadoOriginal() {
        esSuperSaiyan = false
        nivelSuperSaiyan = 0
    }

    method comerSemillaDelErmitano() {
        poderDeAtaque += energiaOriginal * 0.05
    }

    override method sufroAtaque(potencialAtaque) {
        if (esSuperSaiyan) {
            var resistencia
            switch (nivelSuperSaiyan) {
                case 1: resistencia = 0.05
                case 2: resistencia = 0.07
                case 3: resistencia = 0.15
            }
            nivelDeEnergia -= potencialAtaque * (1 - resistencia)
            if (nivelDeEnergia <= energiaOriginal * 0.01) {
                this.volverAEstadoOriginal()
            }
        } else {
            super.sufroAtaque(potencialAtaque)
        }
    }
}



