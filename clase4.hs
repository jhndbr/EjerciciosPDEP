import Text.Show.Functions
j numero = a numero + b numero
-- f numero =   ((+) . b . a) numero

-- f numero = ((+) (a numero) . b) numero

a = (*2)
b = (+3)

f numero = ((+) (a numero) . b) numero
composicion :: (b -> c) -> (a -> b) -> a -> c
composicion f j x = f (j x)

f' numero = (.) ((+) (a numero)) b numero


-- Gravity Falls

-- Criatura peligrosidad: Int, puedeDeshacerse: Persona -> Bool

data Criatura = Criatura {
    peligrosidad:: Int,
    criterioParaDeshacer:: Persona -> Bool
} deriving Show


siempredetras = Criatura {
    peligrosidad = 0,
    criterioParaDeshacer = (\_ -> False)
}

tieneItem :: Item -> (Persona -> Bool)
tieneItem item = elem item . items
tieneSopladorDeHojas = tieneItem "soplador de hojas"

gnomos cantidad = Criatura {
    peligrosidad = 2 ^ cantidad,
    criterioParaDeshacer = tieneSopladorDeHojas
}

diezGnomos = gnomos 10

fantasma asuntoPendiente poder = Criatura {
    peligrosidad = poder * 20,
    criterioParaDeshacer = asuntoPendiente
}

fantasmas = map (fantasma (tieneItem "agua bendita")) [1..10]

-- casper = fantasma comprarChicle 0
-- xsd = fantasma (_ -> True) 100

fantasmaDeLaB = fantasma (\persona -> nivelExperiencia persona > 1000) 10

type Item = String

data Persona = Persona {
    edad :: Int,
    items :: [Item],
    nivelExperiencia :: Int
} deriving Show

mabel = Persona {
    edad = 9,
    items = ["soplador de hojas", "chancho"],
    nivelExperiencia = 100
}

ganarExperiencia persona cantidad =
    persona {
        nivelExperiencia = nivelExperiencia persona + cantidad
    }

enfrentarse :: Persona -> Criatura -> Persona
enfrentarse persona criatura
    | criterioParaDeshacer criatura persona = ganarExperiencia persona (peligrosidad criatura)
    | otherwise = escaparse
    where escaparse = ganarExperiencia persona 1


-- enfrentarTodas persona criaturas = foldl enfrentarse persona criaturas

enfrentarTodas persona = foldl enfrentarse persona

enfrentarse' = flip enfrentarse

enfrentarTodos persona criaturas = foldr (.) id (reverse (map enfrentarse' criaturas)) persona