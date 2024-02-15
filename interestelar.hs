-- Un Planeta se define por su nombre, posición y una función que determina el tiempo que toma viajar a él.
data Planeta = UnPlaneta {
    nombrePlaneta :: String,
    posicionPlaneta :: Posicion,
    tiempoViaje :: Int -> Int
}

-- Una Posicion se define por sus coordenadas x, y, z.
type Posicion = (Float, Float, Float)

-- Un Astronauta se define por su nombre, edad y el planeta en el que se encuentra.
data Astronauta = UnAstronauta {
    nombreAstronauta :: String,
    edadAstronauta :: Int,
    planetaAstronauta :: Planeta
}


distanciaEntrePlanetas :: Planeta -> Planeta -> Float
distanciaEntrePlanetas planeta1 planeta2 = distancia (posicionPlaneta planeta1) (posicionPlaneta planeta2)   

distancia :: Posicion -> Posicion -> Float
distancia (x1, y1, z1) (x2, y2, z2) = sqrt ((x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2)

tiempoDeViaje :: Planeta -> Planeta -> Float -> Float
tiempoDeViaje planeta1 planeta2 = (/) $ distanciaEntrePlanetas planeta1 planeta2

pasarTiempo :: Astronauta -> Int-> Planeta -> Astronauta
pasarTiempo astronauta tiempo planeta = astronauta {edadAstronauta = edadAstronauta astronauta + tiempoViaje planeta tiempo}

type Nave = Planeta -> Planeta -> Float

naveVieja :: Int -> Nave
naveVieja tanquesOxigeno planeta1 planeta2
    | tanquesOxigeno < 6 = tiempoDeViaje planeta1 planeta2 10
    | otherwise = tiempoDeViaje planeta1 planeta2 7

naveFuturista :: Nave
naveFuturista _ _ = 0

viajar :: Astronauta -> Nave -> Planeta -> Astronauta
viajar astronauta nave planetaDestino = astronauta { planetaAstronauta = planetaDestino, edadAstronauta = nuevaEdad }
    where
        tiempoViaje = nave (planetaAstronauta astronauta) planetaDestino
        nuevaEdad = edadAstronauta astronauta + round tiempoViaje

rescatar :: [Astronauta] -> Astronauta -> Nave -> Planeta -> [Astronauta]
rescatar rescatistas varado nave planetaOrigen = rescatistasRegreso ++ [varadoRegreso]
    where
        planetaVarado = planetaAstronauta varado
        tiempoIda = nave planetaOrigen planetaVarado
        tiempoEspera = 2 * tiempoIda
        rescatistasIda = map (\rescatista -> viajar rescatista nave planetaVarado) rescatistas
        rescatistasEspera = map (\rescatista -> pasarTiempo rescatista (round tiempoEspera)) rescatistasIda
        varadoEspera = pasarTiempo varado (round tiempoEspera)
        rescatistasRegreso = map (\rescatista -> viajar rescatista nave planetaOrigen) rescatistasEspera
        varadoRegreso = viajar varadoEspera nave planetaOrigen

puedenSerRescatados :: [Astronauta] -> Nave -> [Astronauta] -> [String]
puedenSerRescatados rescatistas nave varados = map nombreAstronauta $ filter puedeSerRescatado varados
    where -- aca capaz se puede delegar un toque, capaz
        puedeSerRescatado varado = all (<= 90) $ map edadAstronauta $ rescatar rescatistas varado nave (planetaAstronauta $ head rescatistas)