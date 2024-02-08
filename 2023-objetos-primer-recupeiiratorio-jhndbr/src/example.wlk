// por lo que me dijo el ayudate, es el modelo de juan perez por lo que no queda claro la asignacion de responsabilidades
//  
class EmpleadosAcme{
	const lenguajesConocidos = #{}
	const antiguedad = 10 // lo inicialize para que no moleste 

	method antiguedad() = antiguedad
	// nos dejaron a nuestro criterio ejegir cuando sabe un lenguaje antiguo
	method sabeUnLenguajeAntiguo(){
		return lenguajesConocidos.contains("cobol")
	}
	
	method estainvitado()
	
	method esCopado()
	
	method aprendeUnLeguaje(unLenguaje){
		lenguajesConocidos.add(unLenguaje)
	}
	
	method montoRegalo()
	
	 //por la manera de como implemente lenguajes antiguos la 
    method cantidadDeLenguajesModernos(){
    	if (self.sabeUnLenguajeAntiguo()){
    		return lenguajesConocidos.size() - 1
    	}else {
    		return lenguajesConocidos.size()
    	}
    }
    
}

class EmpleadoNoJefe inherits EmpleadosAcme{
	const jefes =#{}
	method agregarJefe(jefe) {
        jefes.add(jefe)
    }

    method eliminarJefe(jefe) {
        jefes.remove(jefe)
    }
    
    override method estainvitado(){
    	self.empleadoEstaInvitado()
    }
	
	override method esCopado(){
    	self.empleadoesCopado()
    }
    method empleadoesCopado()
    method empleadoEstaInvitado()
     method miNumeroDeMesa(){
    	return self.cantidadDeLenguajesModernos()
    }
    
   
    override method montoRegalo() {
        return self.cantidadDeLenguajesModernos() * 1000
    }
}

object desarrollador inherits EmpleadoNoJefe {
    override method empleadoEstaInvitado() {
        return self.sabeWollokOUnLenguajeAntiguo() 
    }
    
    
    method sabeWollokOUnLenguajeAntiguo(){
        	return lenguajesConocidos.contains("wollok") and  self.sabeUnLenguajeAntiguo()
        }
        
        override method empleadoesCopado(){
        	return lenguajesConocidos.size()>2 and self.sabeUnLenguajeAntiguo()
        }
        

}

object infraestructura inherits EmpleadoNoJefe {
    override method empleadoEstaInvitado() {
        return self.sabeMasDe5Lenguajes()
    }
    
    method sabeMasDe5Lenguajes(){
        	return lenguajesConocidos.size() > 5
        }
    override method empleadoesCopado(){
        	return self.antiguedad() > 10
        }
        
}

object jefe inherits EmpleadosAcme {
	const genteACargo = #{}
    override method estainvitado() {
        return self.sabeUnLenguajeAntiguo() and self.tieneACargoGenteCopada()
    }

    method tieneACargoGenteCopada(){
        	return genteACargo.all({empleado=>empleado.esCopado()})
        }
        // el ayudante dice que el jefe nunca es copado
   override method esCopado(){
        	return false
        }
	 method tomaACargo(empleado) {
        genteACargo.add(empleado)
        empleado.agregarJefe(self)
    }

    method eliminarEmpleadoACargo(empleado) {
        genteACargo.remove(empleado)
        empleado.eliminarJefe(self)
    }
   method miNumeroDeMesa(){
    	return 99
    }
    
    override method montoRegalo() {
        return  self.cantidadDeLenguajesModernos() * 1000 + genteACargo.size() * 1000
    }
	        
}


class Empresa {
    const empleados = #{} // todos los empleados
	var invitados = #{}
	method obtenerInvitados() {
        invitados = empleados.filter({empleado => empleado.estainvitado()})
    }
}

class Asistente {
    var property empleado
    var property numeroDeMesa
}

class Fiesta inherits Empresa {
	
    const asistenciaDeEmpleados = #{}
    method llegaInvitado(empleado) {
        if (invitados.contains(empleado)) {
           const asistente = new Asistente(empleado = empleado, numeroDeMesa = self.numeroDeMesaPara(empleado))
            asistenciaDeEmpleados.add(asistente)
        } else {
           //no indicia como no se le debe permitir el ingreso, asumo que es no agregandolo a la lista  
        }
    }

    method numeroDeMesaPara(empleado) {
        return empleado.miNumeroDeMesa()
    }

    method costo() {
        return 200000 + asistenciaDeEmpleados.size() * 5000
    }

    method regalos() {
        const listaderegalos = asistenciaDeEmpleados.map({empleado => empleado.montoRegalo()})
        return listaderegalos.sum()
    }
	
	
	method balaceDeDiesta(){
		return self.costo() - self.regalos()
	}
	
	method fueUnExito(){
		return empleados == asistenciaDeEmpleados
	}
	
	
}
