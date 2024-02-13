data Persona = UnaPersona {
    nick :: String,
    indiceDeFelicidad :: Int,
    librosAdquiridos :: [Libro],
    librosLeidos :: [Libro] 
}

data Libro = UnLibro {
    titulo :: String,
    autor :: String,
    cantidadDePaginas :: Int,
    efectoGenero :: Efecto
}
type Efecto = Persona -> Persona 

comediaDramatica :: Efecto
comediaDramatica persona = persona

comediaAbsurdas :: Efecto 
comediaAbsurdas persona = cambioDeIndice persona (5+) 

comediaSatirica :: Efecto
comediaSatirica persona = cambioDeIndice persona (2*)

comediaOther :: Efecto 
comediaOther persona = cambioDeIndice persona (10+)

--- funciones para no repetir logica
cambioDeIndice :: Persona -> (Int->Int)-> Persona
cambioDeIndice persona funcion = persona { indiceDeFelicidad = calculofelicidad funcion (indiceDeFelicidad persona)}


calculofelicidad :: (Int -> Int) -> Int -> Int
calculofelicidad funcion indice = funcion indice

cienciaFiccion :: Efecto
cienciaFiccion persona = persona { nick = ((\ name -> reverse name) . nick ) persona }

terror :: Efecto 
terror persona = persona { librosAdquiridos = [] }

--------
leeLibro :: Persona -> Libro -> Persona
leeLibro persona libro = (guardaLibro libro ) . (efectoGenero libro) $ persona 

guardaLibro :: Libro ->Persona -> Persona
guardaLibro libro persona = persona { librosAdquiridos = libro : librosAdquiridos persona }

sePoneAldia :: Persona -> Persona
sePoneAldia persona = persona {librosLeidos = (librosNoLeidos persona ++) (librosLeidos persona) }
        where
            librosNoLeidos persona = filter (not.leyoLibro persona) . librosAdquiridos $ persona

leyoLibro :: Persona -> Libro ->Bool
leyoLibro persona libro =  elem (titulo libro) . map titulo $ librosLeidos persona

fanatica :: Persona -> Bool
fanatica persona = all  (ayudita persona) (librosLeidos persona)


ayudita :: Persona ->Libro-> Bool
ayudita persona libro2 = all (titulo libro2==) ( ( map titulo . (take 1) . librosLeidos ) persona)