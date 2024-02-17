ordenarSegun :: (a -> a -> Bool)-> [a] -> [a]
ordenarSegun _ [] = []
ordenarSegun criterio (x:xs) =
  (ordenarSegun criterio . filter (not . criterio x)) xs ++
  [x] ++
  (ordenarSegun criterio . filter (criterio x)) xs

--uso, cabe recarlcar que la lamba puede ser cualquier funcion que reciba dos parametros y devuelva un booleano 
-- ordenarSegun (\a b -> a >b) [1,2,3,4]
-- [4,3,2,1]

-- ordenarSegun (\a b -> length a > length b) ["hola", "nahue", "y", "mora"] orfena de mayor letras a menos
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
data Libro = Libro {
    titulo :: String,
    autor :: String,
    paginas :: Int
} deriving Show

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