ingreso(roque,enero,2000).
ingreso(roque,febrero,3500).
ingreso(roque,marzo,1200).
ingreso(luisa,enero,2500).
ingreso(luisa,febrero,850).

padre(roque,luisa).

buen_pasar(Persona):- ingreso(Persona, enero, Ingreso), Ingreso > 2200.
buen_pasar(Persona):- ingreso(Persona, _, Ingreso), Ingreso > 3000.
buen_pasar(Persona):- ingreso(Persona, Mes, Ingreso), Ingreso > 2500, ingreso(Persona, Mes2, Ingreso2), Mes2 \= Mes, Ingreso2 > 2500.

mes_filial(Persona, Mes):- padre(Hijo, Persona), ingreso(Persona, Mes, Ingreso), ingreso(Hijo, Mes, Ingreso2), Ingreso2 > Ingreso.

ingreso_total(Persona, Total):- findall(I, ingreso(Persona, _, I), T), sumlist(T,Total).

ingreso_familiar(Persona, Total):- ingreso_total(Persona, T1), findall(T, (padre(P,Persona), ingreso_total(P,T)), L), sumlist(L, S), Total is T1 + S.
