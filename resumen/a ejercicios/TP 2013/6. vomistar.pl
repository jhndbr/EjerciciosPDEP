/* vomistar */

empleado(maria, ventas).
empleado(nora, compras).
empleado(felipe, administracion).
empleado(hugo, administracion).
cadete(juan, ventas).
cadete(roque, ventas).
cadete(pedro, compras).
cadete(ana, administracion).

trabaja_en(Empleado, Sector):- empleado(Empleado, Sector); cadete(Empleado, Sector).
trabajan_en_el_mismo_departamento(A, B):- trabaja_en(A, Sector), trabaja_en(B, Sector), A \= B.
puede_dar_ordenes(A, B):- empleado(A, Sector), cadete(B, Sector).