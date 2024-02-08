contador(roque).
abogado(cecilia).
ingeniero(ana).
joven(roque).
honesto(roque).

trabajoEn(roque, acme).
trabajoEn(ana, omni).
trabajoEn(lucia, omni).

habla(roque, frances).
habla(ana, ingles).
habla(ana, frances).
habla(lucia, ingles).
habla(lucia, frances).
habla(cecilia, frances).

ambicioso(cecilia).
ambicioso(P) :- contador(P), joven(P).
tieneXP(P) :- trabajoEn(P,_).

esProfesional(P) :- contador(P).
esProfesional(P) :- abogado(P).
esProfesional(P) :- ingeniero(P).

puedeAndar(comercioExt,P) :- ambicioso(P).
puedeAndar(contaduria,P)  :- contador(P), honesto(P).
puedeAndar(ventas,P)      :- ambicioso(P), tieneXP(P).
puedeAndar(ventas,lucia).
puedeAndar(proyectos,P)   :- ingeniero(P), tieneXP(P).
puedeAndar(proyectos,P)   :- abogado(P), joven(P).
puedeAndar(logistica,P)   :- esProfesional(P), cumpleCond(P).
cumpleCond(P) :- joven(P).
cumpleCond(P) :- trabajoEn(P,omni).

% 3. proyecto pero no contaduria juan
ingeniero(juan).
tieneXP(juan).

% ventas pero no contaduria

ambicioso(pepe).
tieneXP(pepe).




