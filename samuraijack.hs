data Elemento = UnElemento { 
    tipo :: String,
    ataque :: (Personaje-> Personaje),
    defensa :: (Personaje-> Personaje) 
}
data Personaje = UnPersonaje { 
    nombre :: String,
    salud :: Float,
    elementos :: [Elemento],
    anioPresente :: Int 
}
type Anio = Int

type ModificarSalud = Float -> Float


-- 1 --
--1. a. mandarAlAnio: lleva al personaje al año indicado.

mandarAlAnio :: Anio -> Personaje -> Personaje
mandarAlAnio anio personaje = personaje { anioPresente = anio }

-- b. meditar: le agrega la mitad del valor que tiene a la salud del personaje.

meditar ::  Personaje -> Personaje
meditar = modificarLaSalud (flip (/) 2)

-- c. causarDanio: le baja a un personaje una cantidad de salud dada.

causarDanio :: Float -> Personaje -> Personaje
causarDanio cantidadsalud personaje = modificarLaSalud (flip (-) cantidadsalud) personaje

modificarLaSalud :: ModificarSalud -> Personaje -> Personaje
modificarLaSalud modificar personaje = personaje { salud = max 0 .modificar . salud $ personaje }

-- 2 --
-- 2. a. esMalvado, que retorna verdadero si alguno de los elementos que tiene el personaje en cuestión es de tipo “Maldad”.

esMalvado :: Personaje -> Bool
esMalvado personaje = buscarTipoElemento (elementos personaje)

buscarTipoElemento ::  [Elemento] -> Bool
buscarTipoElemento elemento = elem "Maldad" (map (tipo) elemento)

-- 2. b. danioQueProduce :: Personaje -> Elemento -> Float,
-- 2. b. retorna la diferencia entre la salud inicial del personaje y la salud del personaje luego de usar el ataque del elemento sobre él.

danioQueProduce :: Personaje -> Elemento -> Float
danioQueProduce personaje elemento = (salud personaje) - (saludUsarAtaque elemento personaje )

saludUsarAtaque :: Elemento -> Personaje -> Float
saludUsarAtaque elemento personaje = salud (ataque elemento personaje)

-- 2. c. enemigosMortales que dado un personaje y una lista de enemigos, devuelve la lista de los enemigos que pueden llegar a matarlo con un solo elemento. 
-- 2. c. Esto sucede si luego de aplicar el efecto de ataque del elemento, el personaje queda con salud igual a 0.
-- necesito saber si el length de lista de ELEMENTOS es 1 Y si aplicas el ataque al personaje la salud es 0  
-- tambien filtrar los personajes con salud igual a 0

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales personaje enemigos = filter (saludIgualACero (elementos personaje) ) enemigos

saludIgualACero :: [Elemento] -> Personaje -> Bool
saludIgualACero elemento personaje = saludUsarAtaque (llegarAMatarlo personaje elemento) personaje == 0

llegarAMatarlo :: Personaje -> [Elemento] -> Elemento
llegarAMatarlo personaje (x:xs)
    | (saludUsarAtaque x personaje) == 0 = x
    | otherwise = llegarAMatarlo personaje xs


-- 3. Definir los siguientes personajes y elementos:
-- a. Definir concentracion de modo que se pueda obtener un elemento cuyo efecto defensivo sea aplicar meditar tantas veces como el nivel de concentración indicado y cuyo tipo sea "Magia".


concentracion :: Int ->  Elemento
concentracion numero = UnElemento{
    tipo = "Magia",
    ataque = id,
    defensa = aplicarEfecto meditar numero
}

aplicarEfecto :: (Personaje -> Personaje) -> Int -> (Personaje -> Personaje)
aplicarEfecto efecto 0 = efecto
aplicarEfecto efecto cantidadDeVeces = aplicarEfecto efecto (cantidadDeVeces - 1 )

-- 3. b. Definir esbirrosMalvados que recibe una cantidad y retorna una lista con esa cantidad de esbirros (que son elementos de tipo “Maldad” cuyo efecto ofensivo es causar un punto de daño).

esbirrosMalvados :: Int -> [Elemento]
esbirrosMalvados cantidad = replicate cantidad esBirro 

esBirro :: Elemento
esBirro = UnElemento{
    tipo = "Maldad",
    ataque = causarDanio 1,
    defensa = id
}

-- 3. c. Definir jack de modo que permita obtener un personaje que tiene 300 de salud, que tiene como elementos concentración nivel 3 y
--       una katana mágica (de tipo "Magia" cuyo efecto ofensivo es causar 1000 puntos de daño) y vive en el año 200.

jack :: Personaje
jack = UnPersonaje{
    nombre = "jack",
    salud = 300,
    elementos = [ concentracion 3, katanaMagica ],
    anioPresente = 200
}

katanaMagica :: Elemento
katanaMagica = UnElemento{
    tipo = "Magia",
    ataque = causarDanio 1000,
    defensa = id
}

-- 3. d Definir aku :: Int -> Float -> Personaje que recibe el año en el que vive y la cantidad de salud con la que debe ser construido. Los elementos que tiene dependerán en parte de dicho año.

aku :: Int -> Float -> Personaje
aku anio salud = UnPersonaje{
    nombre = "aku",
    salud = salud,
    elementos = [ concentracion 4, portal anio] ++ (esbirrosMalvados (100 * anio)),
    anioPresente = anio
}

portal :: Int -> Elemento
portal anio = UnElemento{
    tipo    = "Magia",
    ataque  = enviarPersonajeAlFuturo anio,
    defensa = generarNuevoAku (anioFuturo anio)
}

generarNuevoAku :: Int -> Personaje -> Personaje
generarNuevoAku anio personaje = personaje { salud = salud personaje, anioPresente = anio}


enviarPersonajeAlFuturo :: Int -> Personaje -> Personaje
enviarPersonajeAlFuturo anio personaje = mandarAlAnio (anioFuturo anio) personaje

anioFuturo :: Int -> Int
anioFuturo = (+2800) 

-- 4. 
luchar :: Personaje -> Personaje -> (Personaje, Personaje)
luchar atacante defensor
    | (==0).salud $ atacante = (defensor, atacante)
    | otherwise = luchar (usarElemento ataque defensor (elementos atacante)) (usarElemento defensa atacante (elementos defensor))

usarElemento :: (Elemento -> Personaje -> Personaje) -> Personaje -> [Elemento] -> Personaje
usarElemento efecto personaje listaElementos = foldl (\personaje aplicarefecto -> aplicarefecto personaje) personaje (map efecto listaElementos)


-- el X :: (C -> ) el Y :: (Int -> C) el Z :: C
-- el (a -> (d, d)) -> [a] -> [d] == map :: (a -> b) -> [a] -> [b]

-- f::(Eq c) =>         X            ->     Y      -> Z -> [a] -> [d]
f :: (Eq c)  => (c -> (a -> (d, d))) -> (Int -> c) -> c -> [a] -> [d]
f x y z
    | y 0 == z = map (fst . x z)
    | otherwise = map (snd . x (y 0))