/* Donde esta el control remoto */

hermano(rodrigo).
hermano(miguel).
hermano(natalia).
esconde(H1, H2):- pelea(H1, H2), not(menor(H1, H2)).
pelea(miguel, H):- hermano(H), not(pelea(rodrigo,H)).
pelea(rodrigo, H):- hermano(H), H \= natalia.
pelea(natalia, H):- pelea(rodrigo, H).
menor(H, rodrigo):- hermano(H), not(pelea(natalia, H)).
