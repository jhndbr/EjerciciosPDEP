data Persona = UnaPersona
    { nombre :: String,
    dinero :: Float
    , suerte :: Int
    , factores :: [(String,Int)]
    } deriving (Show)

nico = (UnaPersona "Nico" 100.0 30 [("amuleto", 3), ("manos magicas",100)])
maiu = (UnaPersona "Maiu" 100.0 42 [("inteligencia",55), ("paciencia",50)])

suerteTotal :: Persona -> Int
suerteTotal unaPersona
    | tieneAmuleto unaPersona >= 0  = (*) (suerte unaPersona) (tieneAmuleto unaPersona)
    | otherwise = suerte unaPersona

tieneAmuleto :: Persona -> Int
tieneAmuleto unaPersona = sum (map snd (valorAmuleto unaPersona))

valorAmuleto :: Persona -> [(String,Int)]
valorAmuleto unaPersona = filter ((== "amuleto") . fst) (factores unaPersona)

data Juego = UnJuego
    { nombreJuego :: String
    , ganancia :: Float -> Float
    , criterio :: Persona -> Bool
    }

ruleta :: Float -> Juego
ruleta jackpot = UnJuego
    { nombreJuego = "Ruleta"
    , ganancia = (*37)
    , criterio = \persona -> suerteTotal persona > 80
    }

maquinita :: Float -> Juego
maquinita jackpot = UnJuego
    { nombreJuego = "Maquinita"
    , ganancia = (+jackpot)
    , criterio = \persona -> suerteTotal persona > 95 && tieneUnFactor persona "paciancia"
    }

tieneUnFactor :: Persona -> String -> Bool
tieneUnFactor unaPersona factor = any ((== factor) . fst) (factores unaPersona)

puedeGanar :: Juego -> Persona -> Bool
puedeGanar = criterio

jugar :: Juego -> Persona -> Float -> Float
jugar juego persona apuesta
    | puedeGanar juego persona = ganancia juego apuesta
    | otherwise = apuesta

gananciaTotal :: Persona -> Float -> [Juego] -> Float
gananciaTotal persona = foldl (\apuesta juego -> jugar juego persona apuesta)

gananciaTotalRec :: Persona -> Float -> [Juego] -> Float
gananciaTotalRec _ apuestaInicial [] = apuestaInicial
gananciaTotalRec persona apuestaInicial (juego:juegos) =
    gananciaTotalRec persona (jugar juego persona apuestaInicial) juegos

jugadoresSinGanar :: [Persona] -> [Juego] -> [String]
jugadoresSinGanar jugadores juegos = 
    map nombre $ filter (not . puedeGanarAlgunJuego juegos) jugadores

puedeGanarAlgunJuego :: [Juego] -> Persona -> Bool
puedeGanarAlgunJuego juegos persona = any (`puedeGanar` persona) juegos

setSaldo :: Float -> Persona -> Persona
setSaldo nuevoSaldo persona = persona { dinero = nuevoSaldo }

apostar :: Juego -> Persona -> Float -> Persona
apostar juego persona apuesta
    | puedeGanar juego persona =  setSaldo (dinero persona - apuesta + ganancia juego apuesta) persona
    | otherwise =  setSaldo (dinero persona - apuesta) persona