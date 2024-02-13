data Granuja = Granuja{
nombre ::String,
fuerza::Int} deriving (Show)
majinBoo= Granuja "Majin Boo" 100
gra1 = Granuja "El cabellero Rojo" 70
gra2 = Granuja "Momia" 10
cambiarFuerza boo granuja = boo{fuerza = fuerza boo + (((length.nombre) granuja)*6)}
fusionarNombre boo granuja = boo{nombre = nombre boo ++ nombre granuja}
modificarBoo1 boo granuja = boo {fuerza = fuerza boo + (((length.nombre) granuja)*6), nombre = nombre boo ++ nombre granuja}
modificarBoo boo granuja = (flip cambiarFuerza granuja . fusionarNombre boo) granuja
mataAEsosGranujas boo listaGranuja = foldl modificarBoo	boo listaGranuja
--fold::(a->b->a)->a->[b] 
matarAEstosGranujas unMonstruo [] = unMonstruo
matarAEstosGranujas unMonstruo (unGranuja:otrosGranujas)= matarAEstosGranujas (modificarBoo1 unMonstruo unGranuja) otrosGranujas
mataAEsosGranujas1 boo  = foldr (flip modificarBoo)	boo
--Definir la función esMultiploDeAlguno/2, que dado un número y una lista de números, devuelve True 
--si el número es múltiplo de alguno de los números de la lista.-
esMultiploDeAlguno numero lista = any ((==0) . (numero `mod`)) lista
esMultiploDe num num1 = (mod num num1) ==0
esMultiploDeAlguno1 numero lista = any (esMultiploDe numero) lista
--1.a) Resolver la función find’ que encuentra el primer elemento que cumple una condición. No se puede 
--resolver con recursividad. Si ningún elemento cumple la condición dejar que falle.
find' :: (a -> Bool) -> [a] -> a
find' condicion = (head . filter condicion)

--1.b) Aprovechar la función find’ para aplicarla a este dominio.
data Politico = Politico {
				proyectos::[String],
				sueldo::Float,
				edad::Int} deriving (Show)

juan = Politico ["tolerancia 100 para delitos"] 15500 49
sergio = Politico ["ser libres", "libre estacionamiento coches politicos", "ley no fumar", "ley 19182"] 20000 81
pedro = Politico ["tratar de reconquistar luchas sociales"] 10000 63
politicos = [ sergio,pedro, juan]
--Queremos encontrar:
--a) un político joven (menos de 50 años)
politicoJoven  = find' (\politico -> edad politico < 50) 
politicoJoven1 = find' ((<50).edad)