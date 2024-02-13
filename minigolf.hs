-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Eq, Show)

-- Jugadores de ejemplo
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b

-- PUNTO 1
putter :: Palo
putter habilidad = UnTiro { velocidad = 10, precision = 2 * precisionJugador habilidad, altura = 0 }

madera :: Palo
madera habilidad = UnTiro { velocidad = 100, precision = precisionJugador habilidad `div` 2, altura = 5 }

hierro :: Int -> Palo
hierro n habilidad = UnTiro { velocidad = fuerzaJugador habilidad * n, precision = precisionJugador habilidad `div` n, altura = max 0 (n - 3) }

--semantica Habilidad -> Tiro
type Palo = Habilidad -> Tiro
-- esto tipa osea podemos declararlos es importante para el parcial pueden pedir algo similar
palos :: [Palo]
palos = [putter, madera] ++ map hierro [1..10]   