%bebida(Nombre, Tipo, Precio, Origen?).
bebida(villavicencio, 	agua_mineral, 	2).
bebida(glaciar, 		agua_mineral, 	3).
bebida(coca_cola, 		gaseosa, 		4).
bebida(goliat, 			gaseosa, 		1).
bebida(bianchi, 		vino, 			7, 	nacional).
bebida(trapiche, 		vino, 			12, nacional).
bebida(richelieu, 		vino, 			13, importado).
bebida(cucagna, 		vino, 			18, importado).
bebida(criadores, 		whiskey, 		20, nacional).
bebida(grants, 			whiskey, 		30, importado).

%cliente(Nombre, Tipo).
cliente(luisa, 		particular).
cliente(ruben, 		particular).
cliente(zoraida, 	comerciante).
cliente(ramon, 		comerciante).

%precio_de_venta(bebida, precio_de_venta, tipo_de_cliente).
precio_de_venta(Bebida, Precio, Cliente):- cliente(Cliente, comerciante), precio_de_comerciante(Bebida, Precio).
precio_de_venta(Bebida, Precio, Cliente):- cliente(Cliente, particular),  precio_de_particular(Bebida, Precio).


precio_de_comerciante(Bebida, Precio):- bebida(Bebida, _, Costo), Precio is Costo * 1.25.
precio_de_comerciante(Bebida, Precio):- bebida(Bebida, vino, Costo, nacional), Precio is Costo * 1.3 + 1.
precio_de_comerciante(Bebida, Precio):- bebida(Bebida, vino, Costo, importado), P1 is Costo * 1.2, P2 is Costo + 3, mayor(P1, P2, Precio).
precio_de_comerciante(Bebida, Precio):- bebida(Bebida, whiskey, Costo, _), Precio is Costo * 1.5.

precio_de_particular(Bebida, Precio):- bebida(Bebida, agua_mineral, Costo), Precio is Costo * 1.3.
precio_de_particular(Bebida, Precio):- bebida(Bebida, gaseosa, Costo), Precio is Costo * 1.4.
precio_de_particular(Bebida, Precio):- bebida(Bebida, _, Costo, nacional), Precio is Costo * 1.6.
precio_de_particular(Bebida, Precio):- bebida(Bebida, _, Costo, importado), Precio is Costo * 1.7.

mayor(A,B,A):- A >= B.
mayor(A,B,B):- A <  B.
