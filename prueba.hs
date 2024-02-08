data Persona = Persona {
    edad :: Int,
    items :: [Item],
    experiencia :: Int
} deriving (Show)

data Item = SopladorDeHojas | DisfrazDeOveja deriving (Show, Eq)

data Criatura = Siempredetras
              | Gnomos Int
              | Fantasma Int (Persona -> Bool)

nivelDePeligrosidad :: Criatura -> Int
nivelDePeligrosidad Siempredetras = 0
nivelDePeligrosidad (Gnomos n) = 2^n
nivelDePeligrosidad (Fantasma poder _) = poder * 20

puedeDerrotar :: Persona -> Criatura -> Bool
puedeDerrotar _ Siempredetras = False
puedeDerrotar persona (Gnomos _) = elem SopladorDeHojas (items persona)
puedeDerrotar persona (Fantasma _ condicion) = condicion persona

enfrentamientoEntre :: Persona -> Criatura -> Persona
enfrentamientoEntre persona criatura
 | puedeDerrotar persona criatura = (incrementarExperienciaEn persona . nivelDePeligrosidad) criatura
 | otherwise = incrementarExperienciaEn persona 1

incrementarExperienciaEn :: Persona -> Int -> Persona
incrementarExperienciaEn persona aumento = persona {experiencia = experiencia persona + aumento}

determinarExperiencia :: Persona -> [Criatura] -> Int
determinarExperiencia persona criaturas = experiencia (enfrentamientoConGrupo persona criaturas)

enfrentamientoConGrupo :: Persona -> [Criatura] -> Persona
enfrentamientoConGrupo = foldl enfrentamientoEntre

zipWithIf :: (a -> b -> b) -> (b -> Bool) -> [a] -> [b] -> [b]
zipWithIf _ _ [] bs = bs
zipWithIf _ _ _ [] = []
zipWithIf f p (a:as) (b:bs)
 | p b       = f a b : zipWithIf f p as bs
 | otherwise = b : zipWithIf f p (a:as) bs


siempreDetras :: Criatura
siempreDetras = Siempredetras

gnomos :: Criatura
gnomos = Gnomos 5

fantasma :: Criatura
fantasma = Fantasma 100 (\persona -> edad persona < 20)


mabel = Persona {
    edad = 30,
    items = [SopladorDeHojas, DisfrazDeOveja],
    experiencia = 100
}