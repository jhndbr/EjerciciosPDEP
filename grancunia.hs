
-- Definición de tipos de datos
data Participante = Participante {
    nombre :: String,
    edad :: Int,
    atractivo :: Float,
    personalidad :: Float,
    inteligencia :: Float,
    criterioVoto :: String -- Supongo que el criterio de voto es una cadena por ahora
} deriving Show

data Prueba = BaileDeTikTok {
    criterioSuperacion :: Bool,
    indiceExito :: Float 
} deriving Show

baileDeTikTok :: Participante -> Prueba
baileDeTikTok participante = BaileDeTikTok {
    criterioSuperacion = atractivo participante > 0.5,
    indiceExito = atractivo participante * 100 + personalidad participante * 100 + inteligencia participante * 100
}

participante1 = Participante "Juan" 25 8.5 25.0 35.0 "Criterio de voto"