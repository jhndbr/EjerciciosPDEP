data Chofer = Chofer {
    nombre :: String,
    kilometraje :: Int,
    viajes :: [Viaje],
    condicionViaje :: CondicionViaje
} 

data Viaje = Viaje {
    fecha :: (Int, Int, Int),
    cliente :: Cliente,
    costo :: Int
} deriving (Show)
type CondicionViaje = Viaje -> Bool

data Cliente = Cliente {
    nombreCliente :: String,
    lugar :: String
} deriving (Show)

cualquierViaje :: CondicionViaje
cualquierViaje _ = True

viajesDe200 :: CondicionViaje
viajesDe200 = (> 200) . costo

clienteNombreLargo :: Int -> CondicionViaje
clienteNombreLargo n = (> n) . length . nombreCliente . cliente

clienteNoViveEn :: String -> CondicionViaje
clienteNoViveEn donde = (/= donde) . lugar . cliente

lucas = Cliente {
    nombreCliente = "Lucas",
    lugar = "Victoria"
}

daniel = Chofer {
    nombre = "Daniel",
    kilometraje = 23500,
    viajes = [viajeLucas],
    condicionViaje = clienteNoViveEn "Olivos"
}
viajeLucas = Viaje {
    fecha = (20, 4, 2017),
    cliente = lucas,
    costo = 150
}

alejandra = Chofer {
    nombre = "Alejandra",
    kilometraje = 180000,
    viajes = [],
    condicionViaje = cualquierViaje
}

puedeTomarViaje :: Viaje -> Chofer -> Bool
puedeTomarViaje viaje chofer = condicionViaje chofer $ viaje

-- Punto 5
liquidacionChofer :: Chofer -> Int
liquidacionChofer chofer = foldr ((+) . costo) 0 (viajes chofer)

-- alternativas
liquidacionChofer2 :: Chofer -> Int
liquidacionChofer2 = sum . map costo . viajes
liquidacionChofer3 chofer = foldl (\acum viaje -> acum + costo viaje) 0 (viajes chofer)

-- Punto 6
realizarViaje :: Viaje -> [Chofer] -> Chofer
realizarViaje viaje = hacerViaje viaje . choferConMenosViajes . filter (puedeTomarViaje viaje)

choferConMenosViajes :: [Chofer] -> Chofer
choferConMenosViajes [chofer] = chofer
choferConMenosViajes (chofer1:chofer2:choferes) = choferConMenosViajes ((elQueMenosViajesHizo chofer1 chofer2):choferes)
-- otra opcion es hacerlo con fold

elQueMenosViajesHizo :: Chofer -> Chofer -> Chofer
elQueMenosViajesHizo chofer1 chofer2
   | cuantosViajes chofer1 > cuantosViajes chofer2 = chofer2
   | otherwise                                     = chofer1

cuantosViajes = length . viajes

hacerViaje viaje chofer = chofer {
    viajes = viaje : viajes chofer
}

-- Punto 7
repetirViaje :: Viaje -> [Viaje]
repetirViaje viaje = viaje : repetirViaje viaje

nito = Chofer "Nito Infy" 70000 viajeInfinito $ clienteNombreLargo 3

viajeInfinito = repetirViaje $ Viaje (11, 3, 2017) lucas 50