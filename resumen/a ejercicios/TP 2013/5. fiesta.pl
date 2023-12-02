/* fiesta */

alumno_de(daniel, luisa).
alumno_de(daniel, juan).
alumno_de(luisa, ana).
alumno_de(nico, diana).
alumno_de(nico, nahuel).
alumno_de(nahuel, tamara).
alumno_de(ruben, claudio).
alumno_de(ruben, jose).
alumno_de(jose, alvaro).
alumno_de(luisa, alvaro).
carilindo(brad).
carilindo(leo).
carilindo(johnny).
simpatico(luciano).
simpatico(lautaro).

puede_ir(nico).
puede_ir(daniel).
puede_ir(X):- alumno_de(Y, X), puede_ir(Y).
puede_ir(X):- carilindo(X). 

/* [debug] 7 ?- puede_ir(X).
X = nico ; X = daniel ;
X = luisa ; X = juan ;
X = ana ; X = diana ;
X = nahuel ; X = tamara ;
X = alvaro ; X = brad ;
X = leo ; X = johnny.

daniel --> 	luisa -->	ana
				  -->	alvaro
	   -->	juan
			
nico --> 	diana
	 -->	nahuel --> 	tamara
			
			
ruben --> 	claudio
	  -->	jose  --> 	alvaro
*/