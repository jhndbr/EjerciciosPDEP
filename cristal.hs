data Aspecto = UnAspecto {
  tipoDeAspecto :: String,
  grado :: Float
} deriving (Show, Eq)

type Situacion = [Aspecto]

mejorAspecto mejor peor = grado mejor < grado peor

mismoAspecto aspecto1 aspecto2 = tipoDeAspecto aspecto1 == tipoDeAspecto aspecto2

buscarAspecto aspectoBuscado = head.filter (mismoAspecto aspectoBuscado)

buscarAspectoDeTipo tipo = buscarAspecto (UnAspecto tipo 0)

reemplazarAspecto aspectoBuscado situacion =
    aspectoBuscado : (filter (not.mismoAspecto aspectoBuscado) situacion)


modificarAspecto :: (Float -> Float) -> Aspecto -> Aspecto
modificarAspecto f aspecto = aspecto { grado = f (grado aspecto) }

esMejor :: Situacion -> Situacion -> Bool
esMejor s1 s2 = all esMejorAspecto (zip ( s1) ( s2))
    where esMejorAspecto (a1, a2) = tipoDeAspecto a1 == tipoDeAspecto a2 && grado a1 > grado a2m 
---esto esta mal creo
modificarSituacion :: Situacion -> String -> (Float -> Float) -> Situacion
modificarSituacion (situacion aspectos) nombreAspecto f = Situacion (map modificarAspecto aspectos)
    where modificarAspecto aspecto
            | nombre aspecto == nombreAspecto = aspecto { grado = f (grado aspecto) }
            | otherwise = aspecto

data Gema = Gema {
    nombreGema :: String,
    fuerza :: Int,
    personalidad :: Situacion -> Situacion
} deriving (Show)

vidente :: Situacion -> Situacion
vidente = modificarSituacion "incertidumbre" (/2) . modificarSituacion "tension" (subtract 10)

relajada :: Int -> Situacion -> Situacion
relajada nivelRelajamiento = modificarSituacion "peligro" (+ fromIntegral nivelRelajamiento) . modificarSituacion "tension" (subtract 30)

ganaA :: Gema -> Gema -> Situacion -> Bool
ganaA gema1 gema2 situacion = fuerza gema1 >= fuerza gema2 && esMejor (personalidad gema1 situacion) (personalidad gema2 situacion)

fusionGema :: Gema -> Gema -> Gema
fusionGema gema1 gema2 = Gema (fusionNombre gema1 gema2) (fusionFuerza gema1 gema2) (fusionPersonalidad gema1 gema2)


fusionNombre :: Gema -> Gema -> String
fusionNombre gema1 gema2
    | nombreGema gema1 == nombreGema gema2 = nombreGema gema1
    | otherwise = nombreGema gema1 ++ " " ++ nombreGema gema2

fusionPersonalidad :: Gema -> Gema -> Situacion -> Situacion
fusionPersonalidad gema1 gema2 situacion = personalidad gema2 (personalidad gema1 (bajarTodosAspectos 10 situacion))

fusionFuerza :: Gema -> Gema -> Situacion -> Int
fusionFuerza gema1 gema2 situacion
    | esMejor (fusionPersonalidad gema1 gema2 situacion) (mejorDe (personalidad gema1 situacion) (personalidad gema2 situacion)) = (fuerza gema1 + fuerza gema2) * 10
    | ganaA gema1 gema2 situacion = fuerza gema1 * 7
    | otherwise = fuerza gema2 * 7

fusionGrupal :: [Gema] -> Situacion -> Gema
fusionGrupal (gema:[]) _ = gema
fusionGrupal (gema1:gema2:gemas) situacion = fusionGrupal (fusion gema1 gema2 situacion : gemas) situacion

--fusion con foldl1
fusionGrupal' :: [Gema] -> Situacion -> Gema
fusionGrupal' gemas situacion = foldl1 (\gema1 gema2 -> fusion gema1 gema2 situacion) gemas 