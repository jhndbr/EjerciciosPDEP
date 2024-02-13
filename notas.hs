--Representamos las notas que se sacó un alumno en dos parciales mediante un par (nota1, nota2), p.ej. un patito en el 1ro y un 7 en el 2do se representan mediante el par (2,7).
-- A partir de esto:
-- 1. Definir la función esNotaBochazo, recibe un número y devuelve True si no llega a 4, False en caso contrario. No vale usar guardas.
-- 2. Definir la función aprobo, recibe un par e indica si una persona que se sacó esas notas
-- aprueba. 
--esNotaBochazo:: Num a=> a -> Bool
esNotaBochazo n = n < 4
type Tupla =(Int,Int)
aprobo:: Tupla -> Bool
aprobo par = (fst par >=6) && (snd par >= 6)
--3. Definir la función promocion, que indica si promocionó, para eso las dos notas 
--tienen que sumar al menos 14 
--y además debe haberse sacado al menos 6 en los dos parciales.
--Siguiendo con el dominio del ejercicio anterior, tenemos ahora dos parciales 
--con dos recuperatorios, lo representamos mediante un par de pares:
--((parc1, parc2), (recup1, recup2))
--Si una persona no rindió un recuperatorio, entonces ponemos un "-1" 
--en el lugar correspondiente. Observamos que con la codificación elegida, 
--siempre la mejor nota es el máximo entre nota del parcial y nota del recuperatorio. 
--Considerar que vale recuperar para promocionar. En este ejercicio vale usar las funciones que
-- se definieron para el anterior.
verifica t = fst t + snd t >= 14
obtenerRecu1  = (snd.fst) 
obtenerRecu2  = (snd.snd) 
notasFinales par | obtenerRecu1 par == -1 && obtenerRecu2 par == -1 = fst par
			| obtenerRecu1 par == -1 = ((fst.fst) par,(snd.snd) par) 
			| obtenerRecu2 par == -1 = ((snd.fst)par, (fst.snd) par)
			| otherwise = snd par
--promocion::Tupla -> Bool
promocion par |  (obtenerRecu1 par == -1) && (obtenerRecu2 par== -1) = ((aprobo.fst) par ) && ((verifica.fst) par)
			| obtenerRecu1 par == -1 = ((aprobo.notasFinales) par) && ((verifica.notasFinales) par) 
			| obtenerRecu2 par == -1 = ((aprobo.notasFinales) par) && ((verifica.notasFinales) par )
			| otherwise = ((aprobo.snd) par ) && ((verifica.snd) par)
--4. Definir la función notasFinales que recibe un par de pares y devuelve el par 
--que corresponde a las notas finales del alumno para el 1er y el 2do parcial. P.ej.
--Main> notasFinales ((2,7),(6,-1))
--(6,7)
--Main> notasFinales ((2,2),(6,2))
--(6,2)
--Main> notasFinales ((8,7),(-1,-1))
multiplico:: (Num a) => a -> a -> a
multiplico n   = (*n)
--6. Crea un tipo de dato Estudiante que contenga el nombre, 
--número de legajo y una tupla de notas donde cada tupla representa las notas de una asignatura.
data Estudiante = Estudiante {
	nombre::String,
	legajo::String,
	notas::Tupla
}
--data Estu =Estu nombre legajo (nota1, nota2)
-- 7. Definir la función promedioNota que recibe un estudiante(tipo) 
-- y devuelve el promedio de sus calificaciones.
promedio (num1,num2) = div (num1 + num2) 2
promedioNota  = (promedio.notas) 
--obtener la cantidad de elementos que son pares dentro de una lista 
--RECURSIVIDAD
contar [] = 0
contar lista | (even.head) lista =1+ (contar.tail) lista
			|otherwise = (contar.tail) lista
--contar (cabeza:cola)
--contar [1,2,3]
-- contar [2,3]
  -- 1+ contar [3]
  --	contar []
transformar n = 1
contar1 lista = foldl (+) 0	(map transformar (filter even lista))
sumarElementos []=0
sumarElementos lista = head lista + (sumarElementos.tail) lista

sumarElementos1 lista = foldl (+) 0 lista
sumarElementos2 lista = foldl1 (+)  lista
			



