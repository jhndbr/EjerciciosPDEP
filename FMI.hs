data Pais = Pais{
    ingresoPerCapita :: Float,
    poblacionActivaPublico :: Int,
    poblacionActivaPrivado :: Int,
    recursosNaturales :: [String],
    deuda :: Float
} deriving (Show)

-- recetas del Fmi

prestarle :: Float -> Pais -> Pais
prestarle  = aumentarDeudaEn 1.5

aumentarDeudaEn :: Float -> Float -> Pais -> Pais
aumentarDeudaEn interes plata pais = pais {deuda = deuda pais + plata * interes}

reducirPuestosPublicos :: Int -> Pais -> Pais
reducirPuestosPublicos cantidad  = disminuirIngresoPercapitaEn . reducirPuestosPublicosEn cantidad

reducirPuestosPublicosEn cantidad pais = pais {poblacionActivaPublico = poblacionActivaPublico pais - cantidad}

disminuirIngresoPercapitaEn pais
    | poblacionActivaPublico pais > 100 = pais {ingresoPerCapita = ingresoPerCapita pais - ingresoPerCapita pais * 0.2}
    | otherwise = pais {ingresoPerCapita = ingresoPerCapita pais - ingresoPerCapita pais * 0.15}

darRecursoAEmpresa :: String -> Pais -> Pais
darRecursoAEmpresa recurso = disminuirDeuda 2000000 . explotarRecurso recurso

disminuirDeuda :: Float -> Pais -> Pais
disminuirDeuda plata pais = pais {deuda = deuda pais - plata}

explotarRecurso :: String -> Pais -> Pais
explotarRecurso recurso pais = pais {recursosNaturales = filter (/= recurso) (recursosNaturales pais)}


establecerBlindaje :: Pais -> Pais
establecerBlindaje = reducirPuestosPublicos 500 . prestarleMitadPBI

prestarleMitadPBI :: Pais -> Pais
prestarleMitadPBI pais = prestarle (pbi pais / 2) pais

pbi :: Pais -> Float
pbi pais = ingresoPerCapita pais * fromIntegral (poblacionActivaPublico pais + poblacionActivaPrivado pais)



paisesQuePuedenZafar :: [Pais] -> [Pais]
paisesQuePuedenZafar = filter (\pais -> "Petróleo" `elem` recursosNaturales pais)

totalDeuda :: [Pais] -> Float
totalDeuda = sum . map deuda

type Receta = Pais -> Pais

recetasOrdenadas :: Pais -> [Receta] -> Bool
recetasOrdenadas _ [] = True
recetasOrdenadas _ [_] = True
recetasOrdenadas pais (receta1:receta2:recetas) =
    let pais1 = receta1 pais
        pais2 = receta2 pais1
    in pbi pais1 <= pbi pais2 && recetasOrdenadas pais2 (receta2:recetas)