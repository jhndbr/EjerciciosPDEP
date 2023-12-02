/* busqueda laboral */

contador(roque).
abogado(cecilia).
ambicioso(cecilia).
habla(ana,frances).
habla(ana,ingles).
habla(cecilia,frances).
habla(lucia,frances).
habla(lucia,ingles).
habla(roque,frances).
honesto(roque).
ingeniero(ana).
joven(roque).
trabajoEn(ana,omni).
trabajoEn(lucia,omni).
trabajoEn(roque,acme).

ambicioso(P):- 
	contador(P), 
	joven(P).

tiene_experiencia(P):- 
	trabajoEn(P,_).

profesional(P):- 
	contador(P); abogado(P); ingeniero(P).

puede_andar_en(P,comercio_exterior):- 
	ambicioso(P).

puede_andar_en(P,contaduria):- 
	contador(P), 
	honesto(P).

puede_andar_en(lucia,ventas).
puede_andar_en(P,ventas):- 
	ambicioso(P), 
	tiene_experiencia(P).

puede_andar_en(P,proyectos):-
	ingeniero(P),
	tiene_experiencia(P).
	
puede_andar_en(P,proyectos):-
	abogado(P),
	joven(P).
	
puede_andar_en(P,logistica):-
	profesional(P),
	(joven(P); trabajoEn(P,omni)).
	
% uno pueda andar para proyectos pero no para logística
ingeniero(juan).
trabajoEn(juan,acme).

% otro pueda andar para ventas pero no para contaduría
ambicioso(jose).
trabajoEn(jose,acme).













