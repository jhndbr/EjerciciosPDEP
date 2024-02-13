data Auto = Auto {
    color :: String,
    velocidad :: Int,
    distancia :: Int
} deriving (Show)

type Carrera = [Auto]


estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = abs (distancia auto1 - distancia auto2) < 10

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto carrera = ningunoCerca auto carrera && esElDeMayorDistancia auto carrera
--funcion compuesta de estaCerca
ningunoCerca :: Auto -> Carrera -> Bool
ningunoCerca auto carrera = not (any (estaCerca auto) (carreraSinUnAuto auto carrera))

carreraSinUnAuto :: Auto -> Carrera -> Carrera
carreraSinUnAuto auto = filter ((/= color auto) . color)
-- saber si un auto tiene mayor distancia Auto -> Carrera  --- importante 
esElDeMayorDistancia :: Auto -> Carrera -> Bool
esElDeMayorDistancia auto = all (\a -> distancia auto >= distancia a)

puesto :: Auto -> Carrera -> Int
puesto auto carrera = 1 + length (filter (distancia auto <) (map distancia ( carrera)))
-- punto 2

correr :: Int -> Auto -> Auto
correr tiempo auto = auto { distancia = distancia auto + tiempo * velocidad auto }

alterarVelocidad :: (Int -> Int) -> Auto -> Auto
alterarVelocidad modificador auto = auto { velocidad = max 0 (modificador (velocidad auto)) }

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad cantidad = alterarVelocidad (subtract cantidad)

--punto 3
terremoto :: Auto -> Carrera -> Carrera
terremoto auto = afectarALosQueCumplen (estaCerca auto) (bajarVelocidad 50)

afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
 = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

miguelitos :: Int -> Auto -> Carrera -> Carrera
miguelitos cantidad auto carrera = afectarALosQueCumplen (flip esElDeMayorDistancia carrera) (bajarVelocidad cantidad) carrera
--casi terminado
--jetPack :: Int -> Auto -> Carrera -> Carrera
--jetPack tiempo auto _ = filter ((== color auto) . color) . map (correr tiempo) $ auto carrera


auto1 = Auto { color = "Auto1", velocidad = 100, distancia = 2000 }
auto2 = Auto { color = "Auto2", velocidad = 80, distancia = 105 }
auto3 = Auto { color = "Auto3", velocidad = 120, distancia = 100 }

carrera = [auto1, auto2, auto3]
