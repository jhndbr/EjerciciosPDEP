
esMultiploDeAlguno num = any (esMultiplo num)
esMultiplo num divisor = mod num divisor == 0


-- encuentra al primer par 
find' :: (a -> Bool) -> [a] -> a
find' condicion = head . filter condicion








data Politico = Politico {proyectosPresentados :: [String], sueldo :: Float, edad :: Int } deriving (Show)

politicos = [ Politico ["ser libres", "libre estacionamiento coches politicos", "ley no fumar", "ley 19182"] 20000 81
            , Politico ["tratar de reconquistar luchas sociales"] 10000 63
            , Politico ["tolerancia 100 para delitos"] 15500 49 
            ]


--find' (\politico -> edad politico < 50) politicos

--find' (\politico -> length (proyectosPresentados politico) > 3) politicos

--find' (\politico -> any (\proyecto -> length (words proyecto) > 3) (proyectosPresentados politico)) politicos