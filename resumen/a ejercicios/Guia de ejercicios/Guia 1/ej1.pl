puedeAndar(comercioExterior,P):- habla(P,ingles), habla(P,frances), profesional(P).
puedeAndar(comercioExterior,P):- ambicioso(P).
puedeAndar(contaduria,P):- contador(P), honesto(P).
puedeAndar(ventas,P):- ambicioso(P), conExperiencia(P).
puedeAndar(ventas,lucia).

puedeAndar(proyectos,P):- ingeniero(P), conExperiencia(P).
puedeAndar(proyectos,P):- abogado(P), joven(P).

puedeAndar(logistica,P):- profesional(P), joven(P).
puedeAndar(logistica,P):- profesional(P), trabajoEn(P, omni).

% proyectos pero no logistica
ingeniero(juan).
trabajoEn(juan, acme).

% ventas pero no contaduria
contador(jose).
joven(jose).
trabajoEn(jose, acme).

profesional(P):- contador(P).
profesional(P):- abogado(P).
profesional(P):- ingeniero(P).

ambicioso(P):- contador(P), joven(P).
conExperiencia(P):- trabajoEn(P,_).

contador(roque).
joven(roque).
trabajoEn(roque,acme).
habla(roque,frances).
honesto(roque).
ingeniero(ana).
habla(ana,ingles).
habla(ana,frances).
trabajoEn(ana,omni).
habla(lucia,ingles).
habla(lucia,frances).
trabajoEn(lucia,omni).
abogado(cecilia).
ambicioso(cecilia).
habla(cecilia,frances).

/*
a. 
puedeAndar: 	mixto
profesional: 	comprension
ambicioso: 		mixto
conExperiencia: comprension
contador: 		extension
joven: 			extension
trabajoEn: 		extension
habla: 			extension
honesto: 		extension
ingeniero: 		extension
abogado: 		extension

b. 
puedeAndar, habla, profesional
se esta definiendo, puedeAndar. los demas son los goles que se tienen que cumplir para que se cumpla puedeAndar.

c. 
puedeAndar(comercioExterior, roque).
	si, pues es ambicioso, (contador y joven).
puedeAndar(comercioExterior, ana). 
	si, pues habla ingles, frances, y es profesional (ingeniera).
puedeAndar(comercioExterior, lucia). 
	no, pues no es profesional ni ambiciosa.
puedeAndar(contaduria, roque).
	si, pues es contador y honesto.
puedeAndar(ventas, roque).
	si, pues es ambicioso(contador joven), y tiene, experiencia (trabajoEn acme).
puedeAndar(ventas, lucia).
	si, hay un hecho para eso
	
d.
puedeAndar(A, B).
	A = comercioExterior, B = P.
habla(ingles, B), habla(frances, B), profesional(B).
	B = ana.
habla(frances, ana), profesional(ana).
profesional(ana).
ingeniera(ana).
true.

e. 
profesional(A).
contador(A).
A = roque.
*/
