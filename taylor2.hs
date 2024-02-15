-------------------------Taylor--------------------------------------------------------------------------

import Data.List (sortOn)
import Data.List (intersect)
data Persona = UnaPersona{
    fanDe :: [Artista],
    tiempoLibre :: Float ,
    estadoAnimico :: Float
}
type Artista = String

type Playlist = [Cancion]

type Categoria= Persona -> Persona

data Cancion = UnaCancion{
    duracion :: Float,
    categoria :: Categoria
}

---------------------------------------------------------

disminucionDeTiempoLibre :: Persona-> Float-> Persona
disminucionDeTiempoLibre persona disminucion = persona{tiempoLibre = (disminucion-).tiempoLibre $ persona }

cambioDeEstadoAnimico ::  (Float->Float) -> Persona-> Persona
cambioDeEstadoAnimico funcion persona = persona{ estadoAnimico = funcion . estadoAnimico $ persona } 

--2 

musicaClasica :: Categoria
musicaClasica personaje = personaje

pop :: Categoria
pop personaje =  cambioDeEstadoAnimico (0.75*) personaje

desAmor :: Float -> Categoria
desAmor intencidad personaje
    | (50<) intencidad && (not.(100<) . estadoAnimico) personaje = cambioDeEstadoAnimico (((2*)intencidad)-) personaje
    | otherwise = disminucionDeTiempoLibre personaje 5

taylorSwift :: Categoria
taylorSwift personaje = cambioDeEstadoAnimico (1+) . desAmor 20.0 . pop $ personaje


--b
escucharCancion :: Persona -> Cancion -> Persona
escucharCancion  personaje cancion = flip disminucionDeTiempoLibre (duracion cancion) . ( categoria cancion) $ personaje

--c
playlist :: Playlist
playlist = [cancion1 , cancion2 , cancion3, cancion4]


cancion1 = UnaCancion 10 (desAmor 30)
cancion2 = UnaCancion 100 pop
cancion3 = UnaCancion 32 taylorSwift
cancion4 = UnaCancion 321 musicaClasica
--a
mayorTiempoLibre :: [Persona] -> Float
mayorTiempoLibre personas =  maximum . map estadoAnimico . filter (\persona -> (0>).estadoAnimico $ persona) $ personas
--b
fanaticosConMayorDe30Minutos :: [Artista]-> [Persona] -> Bool
fanaticosConMayorDe30Minutos artistas personas = all (True==) . map (esFan artistas) . map fanDe . filter (\persona -> (30>).tiempoLibre $ persona) $ personas
                                    where
                                        esFan artistas listaDePersona = (1>=) . length . intersect artistas $ listaDePersona

personasOciosa :: [Persona]-> Persona -> Cancion-> Int
personasOciosa personas ociosa cancion = length . filter (superaAlocioso ociosa cancion) $ personas
                                    where
                                        superaAlocioso ociosa cancion persona = (tiempoLibre . (categoria cancion) $ persona ) >  (tiempoLibre . (categoria cancion) $ ociosa )





escucharPlaylist :: [Persona]->Playlist -> [Persona]
escucharPlaylist personas canciones = take 3 . reverse . sortOn estadoAnimico . map (escuchar canciones) . filter (escuchoCancion canciones) $ personas
                            where 
                                escuchoCancion canciones persona =all (True==). map (escucho persona) $ canciones
                                escuchar canciones persona = foldr ($) persona . map categoria $ canciones

escucho :: Persona -> Cancion -> Bool
escucho persona cancion = (esDiferente persona cancion ). (categoria cancion) $ persona

esDiferente :: Persona ->Cancion-> Persona ->Bool
esDiferente personaOriginal cancion personaModificada =( not . (estadoAnimico personaOriginal ==) . estadoAnimico $ personaModificada ) 

--me falta agregar la opcion de musica clasica pero tengo sueño à