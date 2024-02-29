class CompaniaFiannciera {
	
}

class ClienteEmpleado{
	const bienesRegistrados =#{}
	const hijos
	
	method maximoPrestamo(){
		return self.valorTotalDeBienes()/100 * hijos
	}
	
	method 	valorTotalDeBienes(){
		return bienesRegistrados.map({bien=>bien.precio()}).sum()
	}
}

class Bienes {
	const nombre
	const precio
	
	method precio()= precio
}

class ClienteEmpresa{
	var organizmoGarantia
	const capitalSocial
	method capitalSocial()=capitalSocial
	method 	valorTotalDeBienes(){
		return  organizmoGarantia.importeDePrestamo(self)
	}
}

class FondoDeGarantia{
	const importeDeReferencia
	
	method importeDePrestamo(empresa){
		return self.MenorValor(empresa.capitalSocial(),importeDeReferencia) * 2
	}
	
    method MenorValor(valor1, valor2) {
        if(valor1 < valor2) {
            return valor1
        } else {
            return valor2
        }
    }
	
}
class PoolEmpresas{
	const empresasDePool = #{}
	method importeDePrestamo(empresa){
		return empresasDePool.map({empresaPool=>empresaPool.capitalSocial()}).filter({capitalDeEmpresaPool =>capitalDeEmpresaPool < empresa.capitalSocial()}).sum()
	}
	
}

object Financiera {
    method calcularImportePrestamo(organismo, importeMaximo) {
        const porcentajeGastosAdministrativos = organismo.porcentajeGastosAdministrativos()
        return importeMaximo * (1 - porcentajeGastosAdministrativos / 100)
    }
}


class OrganismoPublico {
	const importeacordado = 1
	method maximoPrestamo(){
		return importeacordado - importeacordado*self.porcentajeGastosAdministrativos()
	}
	
	
     method porcentajeGastosAdministrativos()
}

object poderEjecutivoNacional inherits OrganismoPublico {
    override method porcentajeGastosAdministrativos() {
        return 10
    }
}

object justicia inherits OrganismoPublico {
     override method porcentajeGastosAdministrativos() {
        return 20
    }
}

object enteAutarquico inherits OrganismoPublico {
    override method porcentajeGastosAdministrativos() {
        return 5
    }
}

object gCBA inherits OrganismoPublico {
     override method porcentajeGastosAdministrativos() {
        return 10
    }
}
