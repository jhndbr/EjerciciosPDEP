data Persona = Persona {
    tiempoLibre :: Int,
    estadoDeAnimo :: Int,
    fanDe :: [Artista]
} deriving (Show)
-- Path: taylor.hs
data Cancion = Cancion {
    duracion :: Int,
    categoria :: Categoria
} deriving (Show)

type Playlist = [Cancion]
type Artista = String


reducirTiempoLibre:: Persona -> Int -> Persona
reducirTiempoLibre persona tiempo = persona {tiempoLibre = tiempoLibre persona - tiempo}

cambioEstadoDeAnimo :: Persona -> (Int -> Int) -> Persona
cambioEstadoDeAnimo persona funcion = persona {estadoDeAnimo = funcion (estadoDeAnimo persona)}

type Categoria = Persona -> Int

-- Función de música clásica que no cambia nada
musicaClasica :: Categoria
musicaClasica = estadoDeAnimo

-- Función de música pop que aumenta un 25%
musicaPop :: Categoria
musicaPop persona = estadoDeAnimo persona + round (fromIntegral (estadoDeAnimo persona) * 0.25)

-- Función de desamor
desAmor :: Categoria
desAmor persona
    | estadoDeAnimo persona < 50 = estadoDeAnimo persona - 2 * (estadoDeAnimo persona)
    | estadoDeAnimo persona > 100 = estadoDeAnimo persona
    | otherwise = estadoDeAnimo persona - 5

-- Función de Taylor Swift
taylorSwift :: Categoria
taylorSwift persona =
    let estadoAnimoPop = musicaPop persona
        estadoAnimoDesAmor = desAmor persona
    in estadoAnimoDesAmor + 1

escucharCancion :: Cancion -> Persona -> Persona
escucharCancion cancion persona = 
    Persona { estadoDeAnimo = cancion persona, tiempoLibre = tiempoLibre persona - 1 }


type Categoria = Persona -> Persona

-- Definimos algunas canciones
cancion1 :: Cancion
cancion1 = Cancion { duracion = 5, categoria = musicaClasica }

cancion2 :: Cancion
cancion2 = Cancion { duracion = 3, categoria = musicaPop }

cancion3 :: Cancion
cancion3 = Cancion { duracion = 4, categoria = desAmor }

cancion4 :: Cancion
cancion4 = Cancion { duracion = 6, categoria = taylorSwift }

-- Creamos una playlist con las canciones definidas anteriormente
miPlaylist :: Playlist
miPlaylist = [cancion1, cancion2, cancion3, cancion4]


-- Definimos una función que incrementa un número en 1
incrementar :: Int -> Int
incrementar x = x + 1

persona = Persona { tiempoLibre = 1, estadoDeAnimo = 5, fanDe = ["Taylor"]}


    -- Usamos la función funcionar1 para incrementar el estado de ánimo de la persona


