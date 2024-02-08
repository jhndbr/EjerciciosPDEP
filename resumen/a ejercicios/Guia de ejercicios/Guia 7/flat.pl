flatten(List, FlatList) :- 
	flatten(List, [], FlatList0), !, 
	FlatList = FlatList0.
flatten(Var, Tl, [Var|Tl]) :- 
	var(Var), !.
flatten([], Tl, Tl) :- !.
flatten([Hd|Tl], Tail, List) :- !, 
	flatten(Hd, FlatHeadTail, List), 
	flatten(Tl, Tail, FlatHeadTail).
flatten(NonList, Tl, [NonList|Tl]).

flatten(List,Flat) :- flatten(List,[],Flat).
flatten([], A, A).
flatten([H|Hs], A, Result) :-
    flatten(Hs, A, NewA),
    flatten(H, NewA, Result).
flatten(H, A, [H|A]) :- H\=[], H\=[_|_].

flat(L,R) :- flat(L,[],R).
flat([],A,A).
flat([H|T],A,R) :- flat(T,[H|A],R).
flat([[H]|T],A,R) :- flat(T,[H|A],R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

transpose([], []).
transpose([F|Fs], Ts) :-
    transpose(F, [F|Fs], Ts).

transpose([], _, []).
transpose([_|Rs], Ms, [Ts|Tss]) :-
        lists_firsts_rests(Ms, Ts, Ms1),
        transpose(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :-
        lists_firsts_rests(Rest, Fs, Oss).