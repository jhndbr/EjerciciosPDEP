{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
data Plomero = Plomero{
    nombre :: String ,
    cajaDeHerramientas :: [Herramienta],
     historialDeTrabajos :: [Reparacion],
    dinero :: Float
    }deriving (Show, Eq)
type Trabajo = String
data Herramienta = Herramienta {
    nombreHerramienta :: String,
    costo :: Float,
    materialDeEmpuniadura :: Material
    } deriving (Show, Eq)

data Material = Madera | Plastico | Metal | Goma | Hierro deriving (Show, Eq)

mario :: Plomero
mario = Plomero {
    nombre = "Mario",
    cajaDeHerramientas = [llaveInglesa, martillo],
    historialDeTrabajos = [],
    dinero = 1200
}

wario :: Plomero
wario = Plomero {
    nombre = "Wario",
    cajaDeHerramientas = llavesFrancesas,
    historialDeTrabajos = [],
    dinero = 0.5
}

llaveInglesa :: Herramienta
llaveInglesa = Herramienta {
    nombreHerramienta = "llave inglesa",
    costo = 200,
    materialDeEmpuniadura = Metal
    }

martillo :: Herramienta
martillo = Herramienta {
    nombreHerramienta = "martillo",
    costo = 20,
    materialDeEmpuniadura = Madera
    }
llavesFrancesa :: Herramienta
llavesFrancesa = Herramienta {
    nombreHerramienta = "llave francesa",
    costo = 1,
    materialDeEmpuniadura = Metal
    }

llavesFrancesas :: [Herramienta]
llavesFrancesas = iterate (flip aumentarprecio 1) llavesFrancesa

aumentarprecio :: Herramienta -> Float -> Herramienta
aumentarprecio herramienta cantidad = herramienta {costo = costo herramienta + cantidad }

tieneHerramienta :: Plomero -> String -> Bool
tieneHerramienta plomero nombreHerramientaBuscada = elem nombreHerramientaBuscada $ map nombreHerramienta (cajaDeHerramientas plomero)

esMalvado :: Plomero -> Bool
esMalvado plomero = (== "Wa") $ take 2 (nombre plomero)

puedeComprar :: Plomero -> Herramienta -> Bool
puedeComprar plomero herramienta = dinero plomero >= costo herramienta

-- punto 3

esBuena :: Herramienta -> Bool
esBuena herramienta 
 | herramienta == martillo = tieneEmpuniadura herramienta Madera || tieneEmpuniadura herramienta Goma
 | otherwise = tieneEmpuniadura herramienta Metal
 
tieneEmpuniadura :: Herramienta -> Material -> Bool
tieneEmpuniadura herramienta material = materialDeEmpuniadura herramienta == material

comprarHerramienta :: Plomero -> Herramienta -> Plomero
comprarHerramienta plomero herramienta
    | puedeComprar plomero herramienta = plomero { dinero = dinero plomero - costo herramienta
                                                                                             , cajaDeHerramientas = herramienta : cajaDeHerramientas plomero }
    | otherwise = plomero

data Reparacion = Reparacion { descripcion :: String
                             , requerimiento :: Plomero -> Bool }

filtracionDeAgua :: Reparacion
filtracionDeAgua = Reparacion "Filtración de agua" (\plomero -> LlaveInglesa `elem` cajaDeHerramientas plomero)

esDificil :: Reparacion -> Bool
esDificil reparacion = length (descripcion reparacion) > 100 && all isUpper (descripcion reparacion)

presupuesto :: Reparacion -> Int
presupuesto reparacion = length (descripcion reparacion) * 3

hacerReparacion :: Plomero -> Reparacion -> Plomero
hacerReparacion plomero reparacion
    | puedeHacerReparacion plomero reparacion = plomero { dinero = dinero plomero + presupuesto reparacion
                                                                                                            , historialDeReparaciones = reparacion : historialDeReparaciones plomero
                                                                                                            , cajaDeHerramientas = manejarHerramientas plomero reparacion }
    | otherwise = plomero { dinero = dinero plomero - 100 }

puedeHacerReparacion :: Plomero -> Reparacion -> Bool
puedeHacerReparacion plomero reparacion = requerimiento reparacion plomero || (esMalvado plomero && Martillo `elem` cajaDeHerramientas plomero)

manejarHerramientas :: Plomero -> Reparacion -> [Herramienta]
manejarHerramientas plomero reparacion
    | esMalvado plomero = Destornillador Plastico : cajaDeHerramientas plomero
    | esDificil reparacion = filter (not . esBuena) (cajaDeHerramientas plomero)
    | otherwise = drop 1 (cajaDeHerramientas plomero)

jornadaDeTrabajo :: Plomero -> [Reparacion] -> Plomero
jornadaDeTrabajo = foldl hacerReparacion

masReparador :: [Plomero] -> [Reparacion] -> Plomero
masReparador plomeros reparaciones = maximumBy (comparing (length . historialDeReparaciones . flip jornadaDeTrabajo reparaciones)) plomeros

masAdinerado :: [Plomero] -> [Reparacion] -> Plomero
masAdinerado plomeros reparaciones = maximumBy (comparing (dinero . flip jornadaDeTrabajo reparaciones)) plomeros

masInvertido :: [Plomero] -> [Reparacion] -> Plomero
masInvertido plomeros reparaciones = maximumBy (comparing (sum . map costo . cajaDeHerramientas . flip jornadaDeTrabajo reparaciones)) plomeros