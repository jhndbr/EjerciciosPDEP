/* mensajes_de_texto */
/*
tel(1,"!?@").
tel(2,"abc").
tel(3,"def").
tel(4,"ghi").
tel(5,"jkl").
tel(6,"mno").
tel(7,"pqrs").
tel(8,"tuv").
tel(9,"wxyz").
tel(0," ").

numeros_para([H|F], [N|Ns]):- tel(N, Letras), member(H,Letras), numeros_para(F,Ns).
numeros_para([], []).

numero_gratis(Empresa, [0,8,0,0|Ns]):- numeros_para(Empresa, Ns).
*/

tel(1,'!'). tel(1,'?'). tel(1,'@').
tel(2,'a'). tel(2,'b'). tel(2,'c').
tel(3,'d'). tel(3,'e'). tel(3,'f').
tel(4,'g'). tel(4,'h'). tel(4,'i').
tel(5,'j'). tel(5,'k'). tel(5,'l').
tel(6,'m'). tel(6,'n'). tel(6,'o').
tel(7,'p'). tel(7,'q'). tel(7,'r'). tel(7,'s').
tel(8,'t'). tel(8,'u'). tel(8,'v').
tel(9,'w'). tel(9,'x'). tel(9,'y'). tel(9,'z').
tel(0,' ').

% numeros_para("hola",N).
/*
numeros_para([L|Ls], [N|Ns]):- atom_codes(A, [L]), tel(N,A), numeros_para(Ls, Ns).
numeros_para([], []).
*/
numeros_para([L|Ls], [N|Ns]):- tel(N,A), atom_codes(A, [L]), numeros_para(Ls, Ns).
numeros_para([], []).

numero_gratis(Empresa, [0,8,0,0|Ns]):- numeros_para(Empresa, Ns).