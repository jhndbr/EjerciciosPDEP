-- Parte A
data Usuario = Usuario {
    nickname :: String,
    felicidad :: Int,
    librosAdquiridos :: [Libro],
    librosLeidos :: [Libro]
} deriving Show

data Libro = Libro {
    titulo :: String,
    autor :: String,
    paginas :: Int,
    genero :: Genero
} deriving Show

data Genero = ComediaDramatica | ComediaAbsurda | ComediaSatirica | Comedia | CienciaFiccion | Terror deriving (Show, Eq)
usuario1 = Usuario "user1" 10 [libro1, libro2] [libro1]
libro1 = Libro "Libro 1" "Autor 1" 200 ComediaAbsurda
libro2 = Libro "Libro 2" "Autor 1" 300 CienciaFiccion

efecto :: Genero -> Usuario -> Usuario
efecto ComediaDramatica usuario = usuario
efecto ComediaAbsurda usuario = usuario { felicidad = felicidad usuario + 5 }
efecto ComediaSatirica usuario = usuario { felicidad = felicidad usuario * 2 }
efecto Comedia usuario = usuario { felicidad = felicidad usuario + 10 }
efecto CienciaFiccion usuario = usuario { nickname = reverse (nickname usuario) }
efecto Terror usuario = usuario { librosAdquiridos = [], librosLeidos = [] }

-- Parte B
leerLibro :: Usuario -> Libro -> Usuario
leerLibro usuario libro = efecto (genero libro) (usuario { librosLeidos = libro : librosLeidos usuario })

ponerseAlDia :: Usuario -> Usuario
ponerseAlDia usuario = foldl leerLibro usuario (librosAdquiridos usuario)

esFanatico :: Usuario -> String -> Bool
esFanatico usuario = (==) (mismoAutor' (librosLeidos usuario))

-- funcion que devuelve True si todos los libros tienen el mismo autor
mismoAutor :: [Libro] -> Bool
mismoAutor [] = True
mismoAutor (x:xs) = all ((== autor x) . autor) xs

-- version que devuelve al autor (podria cambiar por alguna otra cosa)
mismoAutor' :: [Libro] -> String
mismoAutor' [] = "no es fanatico"
mismoAutor' (x:xs) 
    | all ((== autor x) . autor) xs = autor x
    | otherwise = "no es fanatico"

tipoDeLibro :: Libro -> String
tipoDeLibro libro
    | paginas libro < 100 = "cuento"
    | paginas libro <= 200 = "novela corta"
    | otherwise = "novela"

librosPorTipo :: Usuario -> String -> [String]
librosPorTipo usuario tipo = map titulo $ filter ((== tipo) . tipoDeLibro) (librosAdquiridos usuario)