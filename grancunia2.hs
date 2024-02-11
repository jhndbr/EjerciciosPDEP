type Criterio = [Participante]->Participante

data Participante = UnParticipante{
    nombre :: String,
    edad :: Int,
    nivelDeAtractivo :: Int,
    nivelDePersonalidad :: Int,
    nivelDeInteligencia :: Int,
    criterioDeVoto :: Criterio
} 

---Pruebas Semanales -> eventos que tienen un criterio para ser superadas 
--1

type Prueba = Participante -> Int

baileDeTiktok :: Participante -> Int
baileDeTiktok participante 
    | condicion (nivelDePersonalidad participante) 20 = ((nivelDePersonalidad participante +).(2*).nivelDeAtractivo) participante
    | otherwise = 0

botonRojo :: Participante -> Int
botonRojo participante 
    | condicion (nivelDePersonalidad participante) 10 && condicion (nivelDeInteligencia participante) 20 = 100
    | otherwise = 0

cuentasRapidas :: Participante -> Int
cuentasRapidas participante 
    | condicion (nivelDeInteligencia participante) 40 = (nivelDeInteligencia participante+) . (nivelDePersonalidad participante-) $  nivelDeAtractivo participante   
    | otherwise = 0

condicion :: Int -> Int -> Bool
condicion nivel numero = numero == nivel
--2
--a 
personasQueSuperanPrueba :: [Participante] -> Prueba-> [Participante]
personasQueSuperanPrueba participante prueba = filter (flip elem [1..100] .prueba) participante  
--b
promedioDeIndiceDeExito :: [Participante] -> Prueba -> Int
promedioDeIndiceDeExito participante prueba =  calculoPromedio . map prueba  . personasQueSuperanPrueba participante $ prueba 

calculoPromedio :: [Int]-> Int
calculoPromedio listaDeIndice = (sum listaDeIndice) div (length listaDeIndice)
--mejorar la composicion 

--c pensar porque esta no funciona .. mejorar la logica con fold
--participanteFavorito :: Participante -> [Prueba] -> Bool
--participanteFavorito participante pruebas =  all (50>) . foldr ((:) . ($)) participante pruebas 


participanteFavorito :: Participante -> [Prueba] -> Bool
participanteFavorito participante pruebas = all (\f -> f participante > 50) pruebas

--3-- Criterios -> segun un criterio retorna una persona


menosInteligente :: Criterio
menosInteligente listaParticipantes = foldl1 personaMenosInteligente listaParticipantes
                where
                    personaMenosInteligente participante1 participante2
                        | nivelDeInteligencia participante1 < nivelDeInteligencia participante2 = participante1
                        | otherwise = participante2


masAtractivo :: Criterio
masAtractivo listaParticipantes = foldl1 mayorAtractivo listaParticipantes 
                where 
                    mayorAtractivo participante1 participante2
                        | nivelDeAtractivo participante1 > nivelDeAtractivo participante2 = participante1
                        | otherwise = participante2


masViejo :: Criterio
masViejo listaDeParticipantes = foldl1 masViejo  listaDeParticipantes
                where 
                    masViejo participante1 participante2
                        | edad participante1 > edad participante2 = participante1
                        | otherwise = participante2
--4


javierTulei = UnParticipante "Javier Tulei" 52 30 70 35 menosInteligente

minimoKirchnner = UnParticipante "Minimo Kirchner" 46 0 40 50 masAtractivo

horacioBerreta = UnParticipante "Horacio Berreta" 57 10 60  50 masAtractivo

myriamBregwoman = UnParticipante "Myriam Bregwoman" 51 40 40 60 masViejo

--5
{-
participantesEnPlaca :: [Participante]->[Participante]
participantesEnPlaca participantes = filter ( quitarRepetidos (repetidosPlaca participantes )) participantes

repetidosPlaca :: [Participante]->[Participante] 
repetidosPlaca participantes = map (personaQueVoto participantes) $ participantes

quitarRepetidos :: [Participante] -> Participante -> Bool
quitarRepetidos participantes participante = participante elem participantes


personaQueVoto :: [Participante] -> Participante -> Participante
personaQueVoto participantes participante = criterioDeVoto participante $ participantes 
-}
--6 

estaEnElHorno :: [Participante]->Participante ->Bool
estaEnElHorno participantes participante = (3>).length.filter (  participante ==) $ (participantesEnPlaca participantes)

hayAlgoPersonal :: [Participante] ->Participante -> Bool
hayAlgoPersonal participantes participante = all (participante == ) . participantesEnPlaca $ participantes 

zafoDePlaca :: [Participante]->Participante -> Bool
zafoDePlaca participantes participante = not . elem participante $ participantes