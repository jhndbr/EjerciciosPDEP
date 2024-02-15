data Animal = Animal {
    nombre :: String,
    tipo :: Int,
    peso :: Int,
    edad :: Int,
    enfermo :: Bool
} deriving (Show)

data Veterinario = Veterinario {
    diagnostico :: Animal -> Int,
    costo :: Int
} 

laPasoMal :: Animal-> Veterinario -> Bool
laPasoMal animal vet = (> 30) $ (diagnostico vet) animal 

nombreFlopa :: Animal -> Bool
nombreFlopa = (== 'i') . last . nombre

-- punto 2
-- funcion para sumar hasta un maximo de 5 en lo que le dan de comida 
incrementarPeso ::Int   -> Animal -> Animal
incrementarPeso comida animal  = animal {peso = (+ peso animal).(min 5) $ (`div` 2) comida}

tratarAnimal :: Animal -> Veterinario -> (Int, Int)
tratarAnimal animal veterinario
    | enfermo animal = ((diagnostico veterinario $ (incrementarPeso 2)$ tratar animal) , (costo veterinario))
    | otherwise = (0, 0)

tratar :: Animal -> Animal
tratar animal = animal {enfermo = False}

festejoCumple :: Animal -> Animal
festejoCumple animal = animal {edad = (+1) $ edad animal, peso = ((-)1) $ peso animal} 

chequeoDePeso :: Animal -> Int -> Animal
chequeoDePeso animal pesoMax 
    | peso animal > pesoMax = animal
    | otherwise = animal {enfermo = True}

-- punto 3
-- incremetarPeso SE USARIA CON FLIP
type FuncionAnimal = Animal -> Animal

evaluarAnimal :: Animal -> [FuncionAnimal] -> Animal
evaluarAnimal = foldl (flip ($))
-- PUNTO 4 
evaluarPeso :: Animal -> [FuncionAnimal] -> String
evaluarPeso animal funciones
    | deltaPeso < 0 || deltaPeso > 3 = "El peso del animal cambio de manera inadecuada"
    | otherwise = "El peso del no animal cambio de manera inadecuada"
    where
        animalFinal = evaluarAnimal animal funciones
        deltaPeso = peso animalFinal - peso animal
-- Punto 5 
--a
-- usar filter y take 


