data Auto = Auto {
    color :: String,
    velocidad :: Int,
    distancia :: Int
} deriving (Show)

data Carrera = Carrera {
    autos :: [Auto]
} deriving (Show)


estaCerca :: Auto -> Auto -> Bool
estaCerca auto1 auto2 = abs (distancia auto1 - distancia auto2) < 10

vaTranquilo :: Auto -> Carrera -> Bool
vaTranquilo auto = ningunAutoCerca auto . mayorDistancia auto
--funcion compuesta de estaCerca
ningunAutoCerca :: Auto -> Carrera -> Bool
ningunAutoCerca auto carrera = all (not . estaCerca auto) (autos carrera)
-- funcion para saber si es el mayor de una lista segun un "atributo"
mayorDistancia :: Auto -> Carrera -> Bool
mayorDistancia auto carrera = all (distancia auto >) (map distancia (autos carrera))
-- funcion para saber el puesto de un elemento en una lista
puesto :: Auto -> Carrera -> Int
puesto auto carrera = 1 + length (filter (distancia auto <) (map distancia (autos carrera)))

-- punto 2

correr :: Int -> Auto -> Auto
correr tiempo auto = auto { distancia = distancia auto + tiempo * velocidad auto }

alterarVelocidad :: (Int -> Int) -> Auto -> Auto
alterarVelocidad modificador auto = auto { velocidad = max 0 (modificador (velocidad auto)) }

bajarVelocidad :: Int -> Auto -> Auto
bajarVelocidad cantidad = alterarVelocidad (subtract cantidad)

-- punto 3

