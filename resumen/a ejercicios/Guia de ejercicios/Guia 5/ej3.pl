empleado(juan).
empleado(marcelo).
empleado(adriana).
empleado(francisco).
empleado(alberto).
empleado(cristian).
empleado(mariana).

jefe(marcelo, juan).
jefe(marcelo, adriana).
jefe(mariana, cristian).

area(marcelo, administracion).
area(mariana, ventas).

interno(marcelo, 2244).
interno(adriana, 2245).
interno(francisco, 4441).
interno(alberto, 4442).
interno(mariana, 1212).

gerente(alberto, administracion).
asistente(francisco, alberto).

% interno_de
interno_de(Persona, Interno):- interno(Persona, Interno).
interno_de(Persona, Interno):- empleado(Persona), not(interno(Persona,_)), jefe(Jefe, Persona), interno(Jefe, Interno).

% quien_atiende
quien_atiende(Interno, Persona):- interno(Jefe, Interno), jefe(Jefe, Persona). 
quien_atiende(Interno, Persona):- interno(Gerente, Interno), gerente(Gerente, _), asistente(Persona, Gerente).
quien_atiende(Interno, Persona):- interno(Persona, Interno), not(jefe(Persona, _)), not(gerente(Persona, _)).

% depende_de
depende_de(A, B):- jefe(B, A).
depende_de(A, B):- area(A, Area), gerente(B, Area).

% puede_transferir
puede_transferir(I1, I2):- interno(E1, I1), interno(E2, I2), depende_de(E1, Persona), depende_de(E2, Persona).

% pertenecen
pertenecen(Lista, Internos):- findall(I, (member(I,Lista), interno(_, I)), Internos).

% personas
personas(Personas, Internos):- findall(I, (member(P, Personas), interno_de(P, I)), Internos).

