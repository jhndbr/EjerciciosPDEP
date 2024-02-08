data Granujas = Granujas {
    nombre :: String
} deriving (Show)

data Maginboo = Maginboo {
    nombreMaginboo :: String,
    poder :: Int
} deriving (Show)


fucionarNombre :: Maginboo -> Granujas -> Maginboo
fucionarNombre maginboo granuja = maginboo {nombreMaginboo = nombre granuja ++ nombreMaginboo maginboo}

nuevaFuerza :: Maginboo -> Granujas -> Maginboo
nuevaFuerza maginboo granuja = maginboo {poder = poder maginboo + length (nombre granuja) * 6 }

cambiarboo :: Maginboo -> Granujas -> Maginboo
cambiarboo maginboo granuja = flip fucionarNombre.nuevaFuerza maginboo granuja 

mataAEsosGranujasFoldl :: Maginboo -> [Granujas] -> Maginboo
mataAEsosGranujasFoldl = foldl (\maginboo granuja -> nuevaFuerza (fucionarNombre maginboo granuja) granuja)

mataAEsosGranujasFoldr :: Maginboo -> [Granujas] -> Maginboo
mataAEsosGranujasFoldr = foldr (\granuja maginboo -> nuevaFuerza (fucionarNombre maginboo granuja) granuja)

mataAEsosGranujasFoldl :: Maginboo -> [Granujas] -> Maginboo
mataAEsosGranujasFoldl = foldl cambiarboo

mataAEsosGranujasFoldr :: Maginboo -> [Granujas] -> Maginboo
mataAEsosGranujasFoldr = foldr (flip cambiarboo)