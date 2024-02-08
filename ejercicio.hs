aprueba :: String -> Int
aprueba persona
    | persona == "vago" = 10
    | persona == "inteligente" = 60
    | persona == "estudioso" = 100
    | otherwise = 50


esNotaBochazo :: Int -> Bool
esNotaBochazo nota = nota < 4

aprobo :: (Int, Int) -> Bool
aprobo (nota1, nota2) = not (esNotaBochazo nota1 || esNotaBochazo nota2)

type Tupla = (Int, Int)

sumarTupla :: Tupla -> Int
sumarTupla (x, y) = x + y

aproboTupla :: Tupla -> Bool
aproboTupla (x, y) = aprobo (x, y)