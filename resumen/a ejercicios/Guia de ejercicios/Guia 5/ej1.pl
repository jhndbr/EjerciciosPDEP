/* recursividad */

s(a,b). s(a,c). s(b,c). s(c,d).
s(e,f). s(f,g). s(f,h).

p(A,B):- s(A,B).
p(A,C):- s(A,B), p(B,C).

